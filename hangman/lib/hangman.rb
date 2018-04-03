require 'yaml'

#let the player save the game at the beginning of each turn
class Hangman
  attr_reader :max_guesses, :incorrect_guesses, :random_word

  def initialize
    puts "Would you like to start a new game(1) or load a previous game(2)?"
    if gets.chomp == "1"
      setup
    else
      load_game
    end
  end

  def setup
    @filename = '../dictionary.txt'
    @max_guesses = 6
    @total_guesses = 0
    @incorrect_guesses = []
    @already_guessed = []
    @answer = {}
    @dictionary = load_dictionary
    @random_word = generate_random_word
    @board = Array.new(@random_word.length, nil)
    instructions
  end

  def load_dictionary
    File.open(@filename).to_a.map { |word| word.downcase.gsub(/\n/,'') }
  end

  def generate_random_word
    @random_word = @dictionary.each { |word| word.length >= 5 && word.length <= 12 }[(1 + rand(@dictionary.size))]
  end

  def instructions
    puts "Welcome to Hangman!"
    puts "You will be given 6 guesses to determine what the secret word is."
    puts "Each incorrect guess will be displayed, as well as the number of remaining guesses."
  end

  def print_board
      @answer.each do |letter, position|
        position.each do |pos|
          @board[pos] = letter
        end
      end

      @board = @board.map { |value| value.nil? ? "_ " : value }
      puts "#{@board.join(' ')} \n\n\n"
  end

  def validate_guess(guess)
    if @already_guessed.include? guess
      puts "You have already guessed that letter!"
      return false
    end

    if guess =~ /[^a-z]/
      puts "Your guess can only contain letters (a-z)."
      return false
    end

    return true
    #-the word doesn't save the game?
  end

  def incorrect_guess(guess)
    @incorrect_guesses << guess
  end

  def correct?(guess)
    return true if @random_word.include? guess
    return false
  end

  def victory?
    return true if @random_word == @board.join('')
    return false
  end

  def play
    while true
      if @total_guesses >= 6
        puts "Sorry! You lost. This was the correct solution: #{@random_word}"
        break
      end

      print_board

      if victory?
        puts "Congratulations! You won!"
        break
      end

      print "Enter a letter: "
      @guess = gets.chomp.downcase

      if @guess == "save"
        save_game
        break
      end

      if validate_guess(@guess)
        @already_guessed << @guess
        if correct?(@guess)
          @answer[@guess] = (0...@random_word.length).find_all { |i| @random_word[i] == @guess }
        else
          @total_guesses += 1
          puts "Incorrect guesses: #{incorrect_guess(@guess)} \n\n\n"
        end
      end # validate_guess
    end # while
  end # play

  def save_game
    status = [@random_word, @already_guessed, @incorrect_guesses, @max_guesses, @board, @answer, @total_guesses]
    File.open("save.yaml", "w") do |file|
      file.puts YAML::dump(status)
    end
  end

  def load_game
    data = YAML::load(File.open("save.yaml"))
    puts "You loaded your last saved game."
    @random_word = data[0]
    @already_guessed = data[1]
    @incorrect_guesses = data[2]
    @max_guesses = data[3]
    @board = data[4]
    @answer = data[5]
    @total_guesses = data[6]
    puts "Incorrect guesses: #{incorrect_guess(@guess)}"
  end

end

game = Hangman.new
game.play
