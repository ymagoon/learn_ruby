#write your code here
def echo(phrase)
  return phrase
end

def shout(phrase)
  return phrase.upcase
end

def repeat(phrase, times = 2)
  return ("#{phrase} " * times).strip
end

def start_of_word(word, num)
  return word[0...num]
end

def first_word(sentence)
  return sentence.split.first
end

def titleize(sentence)
  arr = []
  sentence.split.each_with_index do |word, index|
    puts word
    if (word != "and" && word != "over" && word != "the") || ( word == "the" && index == 0 )
      arr << word.capitalize
    else
      arr << word
    end
  end

  return arr.join(' ')
end
