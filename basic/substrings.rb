=begin
Implement a method #substrings that takes a word as the first argument and then
an array of valid substrings (your dictionary) as the second argument.
It should return a hash listing each substring (case insensitive) that was found
in the original string and how many times it was found.
=end

def substrings(word, subs)
  dic = {}
  subs.each do |sub|
    dic[sub] = word.scan(/(?=#{sub})/).count
  end
  return dic
end

puts substrings("banana", ["an","ba"])

=begin
def anagram_hash(string1,string2)
  h1 = string1.chars.each_with_object(Hash.new(0)) { |letter, h| h[letter] += 1 }
  h2 = string2.chars.each_with_object(Hash.new(0)) { |letter, h| h[letter] += 1 }

  if h1 == h2
    return true
  else
    return false
  end
end

puts anagram_hash("eighteen", "eihgtnee")
=end
