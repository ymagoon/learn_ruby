require 'csv'
require 'erb'
require 'google/apis/civicinfo_v2'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,'0')[0..4]
  #return zipcode
end

def clean_phone_numbers(phone)
  phone = phone.gsub(/[^0-9]+/,'')

  if phone.length > 10 && phone[0] == "1"
    phone = phone[1..-1] if phone[0] == 1 # trim country code
    return "#{phone[0..2]}-#{phone[3..5]}-#{phone[6..9]}"
  elsif phone.length < 10 || phone.length > 10
    "Invalid phone number"
  else
    return "#{phone[0..2]}-#{phone[3..5]}-#{phone[6..9]}"
  end
end

def format_date(date)
  frmt_date = date.split(' ')[0].split('/').map { |date| date.rjust(2,'0') } + date.split(' ')[1].split(':')
  formatted_date = "#{frmt_date[0]}-#{frmt_date[1]}-20#{frmt_date[2]} #{frmt_date[3]}:#{frmt_date[4]}"

  formatter = '%m-%d-%Y %H:%M'
  date = DateTime.strptime(formatted_date,formatter)
  return date
end

def frequency(value)
  freq = value.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

  frequency = freq.keys.sort_by { |key| freq[key] }.map do |key|
    key
  end

  return frequency[-3..-1]
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
          address: zipcode,
          levels: 'country',
          roles: ['legislatorUpperBody', 'legislatorLowerBody']).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letters(id, name, form_letter)
  Dir.mkdir('../output') unless Dir.exist? '../output'
  filename = "../output/thanks_#{id}_#{name}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

template_letter = File.read("../form_letter.erb")
erb_template = ERB.new(template_letter)

hour = []
day_of_week = []

contents = CSV.open('../event_attendees.csv', headers: true, header_converters: :symbol)
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  phone = clean_phone_numbers(row[:homephone])
  hour << format_date(row[:regdate]).hour
  day_of_week << Date::ABBR_DAYNAMES[format_date(row[:regdate]).wday]
  form_letter = erb_template.result(binding)

  save_thank_you_letters(id, name, form_letter)
end

hour_frequency = frequency(hour)
day_of_week_frequency = frequency(day_of_week)
