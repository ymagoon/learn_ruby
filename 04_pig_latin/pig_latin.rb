#write your code here
def translate(words)
  store = []
  words.split.each do |word|
    word.downcase!

    run = true
    while run
      if word[0] =~ /[aeiou]/
        run = false
        store << word + 'ay'
      elsif word[0..1] =~ /qu/
        word = word[2..-1] + 'qu'
      elsif word[0] =~ /[^aeiou]/
        word = word[1..-1] + word[0]
      end
    end
  end
  return store.join(' ')
end
