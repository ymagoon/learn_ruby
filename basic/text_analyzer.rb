=begin
1. Load in a file containing the text or document you want to analyze.
2. As you load the file line by line, keep a count of how many lines there were (one of your
statistics taken care of).
3. Put the text into a string and measure its length to get your character count.
4. Temporarily remove all whitespace and measure the length of the resulting string to
get the character count excluding spaces.
5. Split out all the whitespace to find out how many words there are.
6. Split on full stops to find out how many sentences there are.
7. Split on double newlines to find out how many paragraphs there are.
8. Perform calculations to work out the averages.
=end
# todo;- object orient the shit out of this awesome code!

# to explain why I am using foreach and not .read or .readlines
# https://stackoverflow.com/questions/25189262/why-is-slurping-a-file-not-a-good-practice
# https://stackoverflow.com/questions/6012930/how-to-read-lines-of-a-file-in-ruby
text = ''
line_count = 0
stopwords = %w{the a by on for of are with just but and to the my I has some in as if be do is it It And This so all an}

File.foreach('test.txt').with_index do |line, line_num|
  line_count += 1
  text << line
end

chr_count = text.length # includes \n characters
chr_count_only_text = text.gsub(/\s+/,'').length # remove spaces and \n
words = text.split(' ').size
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length
avg_words_per_sentence = words / sentence_count
avg_sentence_per_paragraph = sentence_count / paragraph_count

puts "Line count: #{line_count}"
puts "Character count: #{chr_count}"
puts "Character count spaces removed: #{chr_count_only_text}"
puts "Word count: #{words}"
puts "Sentence count: #{sentence_count}"
puts "Paragraph count: #{paragraph_count}"
puts "Average words per sentence: #{avg_words_per_sentence}"
puts "Average sentence per paragraph: #{avg_sentence_per_paragraph}"

words = text.gsub(/\'/,'').scan(/\w+/)
keywords = words.select { |word| !stopwords.include? word }

keywords_vs_words = keywords.size.to_f / words.size
puts keywords_vs_words

frequency = keywords.each_with_object(Hash.new(0)) do |i, h|
  h[i] += 1
end

puts frequency.select { |words,freq| freq > 2 }.inspect

sentences = text.gsub(/\s+/,' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }
#puts ideal_sentences.inspect
