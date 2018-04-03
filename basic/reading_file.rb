require 'csv'
require 'pstore'
require 'yaml'
require 'postgres'
#CSV.open('reading_file.txt','r').each do |person|
#  puts person.inspect
#end

#people = CSV.parse(File.read('reading_file.txt'))

#people = CSV.read('reading_file.txt')
#laura = people.find { |person| person[0] =~ /Laura/ }
#laura[0] = "Lauren Smith"

#CSV.open('reading_file.txt', 'w') do |csv|
#  people.each do |person|
#    csv << person
#  end
#end
#young_people = people.find_all { |person| person[3].to_i.between?(20,40) }
#puts young_people.inspect

#pstore
=begin
class Person
  attr_accessor :name, :job, :gender, :age
end

fred = Person.new
fred.name = "Fred Bloggs"
fred.age = 45
laura = Person.new
laura.name = "Laura Smith"
laura.age = 23

store = PStore.new("storagefile")
store.transaction do
  store[:people] ||= Array.new
  store[:people] << fred
  store[:people] << laura
end

people = []
store.transaction do
  people = store[:people]
end

people.each do |person|
  puts person.name
end
=end
class Person
  attr_accessor :name, :age
end

fred = Person.new
fred.name = "Fred Bloggs"
fred.age = 45

laura = Person.new
laura.name = "Laura Smith"
laura.age = 23

test_data = [fred, laura]

puts YAML::dump(test_data)

yaml_string = <<END
---
- !ruby/object:Person
  name: Jimmy Bloggs
  age: 45
- !ruby/object:Person
  name: Laura Smith
  age: 23
END

test_data = YAML::load(yaml_string)
puts test_data[0].name
