=begin
Now refactor your code to allow the human player to choose whether she wants to be the creator of the secret code or the guesser.
Build it out so that the computer will guess if you decide to choose your own secret colors. Start by having the computer guess randomly (but keeping the ones that match exactly).
Next, add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, its next guess will need to include that color somewhere. Feel free to make the AI even smarter.
=end

class Mastermind
  @max_turns = 12

  def initialize
    instructions
    @code = SecretCode.new

    play
  end

  def instructions
    puts 'Welcome to Mastermind!'
    puts %q{
      These are the rules:
      -From left to right, enter a letter for each color (ex. rbgy)
      -Possible colors are: r g b y w
      -No repeated colors in the code
      -Each 'o' means there is a color AND placement correct
      -Each 'x' means there is one color correct with a wrong placement
      -The order of x's and o's does not indicate that is the order
    }

  end

  def play
    puts "The game can be played with either the computer guessing your code or you guessing the computer's code"
    puts %q{
    (1)Would you like to Code Breaker?
    (2)Would you like to be the Code Guesser?
  }
    @player = gets.chomp

    puts 'You have 12 guesses to figure out the code! Good luck!'
    @guesses = Guess.new
    puts @code.show

    i = 0
    while i < 12
      @guesses.show
      print 'Enter your guess: '
      guess = gets.chomp

      if @guesses.valid?(guess)
        if @code.correct?(guess)
          puts 'You are correct!'
          break
        else
          @hints = @code.generate_hints(guess)
        end
        @guesses.store(guess, @hints)
      end

      i += 1
    end
  end
end

class SecretCode
  def initialize
    @code = 'rbgyw'
    generate_code
  end

  def generate_code
    @code = @code.chars.shuffle.join[0...-1]
  end

  def generate_hints(guess)
    color_and_placement = 0
    color = 0

    guess.each_char.with_index do |c,index|
      color_and_placement += 1 if c == @code[index]
      color += 1 if @code.include? c
    end

    color -= color_and_placement # subtract duplicates so color is accurate
    return "#{'x' * color}#{'o' * color_and_placement}"
  end

  def show
    @code
  end

  def correct?(guess)
    @code == guess ? true : false
  end
end

class Guess
  def initialize
    @guesses = []
  end

  def store(guess, hint)
    @guesses << [guess,hint]
  end

  def show
    @guesses.each do |guess|
      puts "(#{guess[0][0]}) (#{guess[0][1]}) (#{guess[0][2]}) (#{guess[0][3]}) #{guess[1]}"
    end
  end

  def valid?(guess)
    if guess.length > 4
      puts 'You cannot guess more than four codes at once'
      return false
    end

    letter_cnt = guess.chars.each_with_object(Hash.new(0)) do |i,h|
      h = h[i] += 1
    end

    if letter_cnt.any? { |k,v| v > 1 }
      puts 'You cannot enter duplicate colors'
      return false
    end
    return true
  end
end

Mastermind.new
