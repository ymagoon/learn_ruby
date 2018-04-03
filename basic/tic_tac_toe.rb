class Game
  attr_accessor :player1, :player2, :board

  WINNING_LINES = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize
    puts "Welcome to Tic-Tac-Toe, the most epic game ever :D"
    puts "This is a two player game, so please enter who you are!"
    @player1 = Player.new(get_player(1), 1, 'X')
    @player2 = Player.new(get_player(2), 2, 'O')
    @player = @player1  # active player, player1 starts
    @board = Board.new
    instructions

    play
  end

  def get_player(n)
    print "Player #{n}: "
    return gets.chomp
  end

  def instructions
    puts "                    ***INSTRUCTIONS***"
    puts %Q{
      The game board is separated into 9 squares.

      |1|2|3|
      |4|5|6|
      |7|8|9|

      To make a move, enter the number of the square
      you want to play!

      Player 1 = X's
      Player 2 = O's

      Good luck!\n\n}
  end

  def play # loop here for gameplay
    @board.print_board

    while true # while no victory
      move
      if victory?
        puts "Congrats #{@win.name}! You won!!!"
        break
      end
      
      if board_full?
        puts "It's a cats game!"
        break
      end
      next_turn
    end
  end

  def move
    print "#{@player.name}, you are up! Enter your move (1 - 9): "
    player_move = gets.chomp.to_i - 1

    if @board.valid_move?(player_move)
      @board.update_board(player_move, @player.x_or_o)
    else
      puts "That's not a valid move!"
      move
    end
    @board.print_board
  end

  def victory? # checks for 3 in a row
    if WINNING_LINES.any? { |line| line.all? { |n| @board.board[n] == @player.x_or_o } }
       @win = @player
    end

  end

  def board_full?
    @board.board.all? { |value| !value.empty? }
  end

  def next_turn
    @player == @player1 ? @player = @player2 : @player = @player1
  end

  class Player
    attr_accessor :name, :number, :x_or_o

    def initialize(name, number, x_or_o)
      @name = name
      @number = number
      @x_or_o = x_or_o
    end
  end

  class Board
    attr_accessor :board
    def initialize
      @board = Array.new(9, '')
      puts @board.inspect
    end

    def print_board
      puts "|#{@board[0].empty? ? ' ' : @board[0]}|#{@board[1].empty? ? ' ' : @board[1]}|#{@board[2].empty? ? ' ' : @board[2]}|"
      puts "|#{@board[3].empty? ? ' ' : @board[3]}|#{@board[4].empty? ? ' ' : @board[4]}|#{@board[5].empty? ? ' ' : @board[5]}|"
      puts "|#{@board[6].empty? ? ' ' : @board[6]}|#{@board[7].empty? ? ' ' : @board[7]}|#{@board[8].empty? ? ' ' : @board[8]}|"
      puts "\n\n\n"
    end

    def valid_move?(move)
      if move > -1 && move < 9
        @board[move].empty? ? true : false
      end
    end

    def update_board(move, x_or_o)
      @board[move] = x_or_o
    end
  end
end

game1 = Game.new
