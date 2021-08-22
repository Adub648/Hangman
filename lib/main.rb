require 'json'
require_relative 'display'
require_relative 'gameLogic'
require_relative 'saveLogic'

class Main
  include Display
  include GameLogic
  include SaveLogic

  def prepare_game(game)
    @game = game
    @finished = false
    @exempt = false
    @loading_game = false
    @user_guess = []
    @incorrect_guess = []
    @guesses_remaining = 8
    @dictionary = File.read("5desk.txt").split
    generate_word
  end

  def generate_word
    @word = @dictionary[rand(@dictionary.length)]
    check_word
  end

  def check_word
    if @word.length > 12 || @word.length < 5
      generate_word
    else
      @word = @word.downcase
      start_game
    end
  end

  def start_game
    options
    if @word.is_a?(String)
      @word = @word.split('')
    end
    # generate array for user guesses
    @word.length.times { |i| @user_guess[i] = ""}
    while @guesses_remaining > 0
      user_turn
    end
    @word = @word.join("")
    lost_game
  end

  def options
    puts @game.display_info
    puts "Would you like to: 1) Play new game? or 2) Play saved game?"

    puts "Please enter either the number '1' or the number '2'"
    puts "\n"
    input = gets.chomp
    if input == "1"
      return
    elsif input == "2"
      load_game
    else
      puts "You have not entered '1' or '2'! Please try again."
      options
    end
  end

  def user_turn
    if @guesses_remaining == 8
      @guesses_remaining -= 1
    else
      puts "You have #{@guesses_remaining} incorrect guesses remaining."
      puts "\n"
      puts "Previous incorrect characters guessed are: #{@incorrect_guess.join(", ")}"
      puts "\n"
      puts "\n"
      puts "Enter 'SAVE' to save the game, 'LOAD' to load the game or 'EXIT' to exit the game"
      puts "\n"
      puts "Enter a character: "
      input = gets.chomp
      validate_response(input)
    end
  end

  def lost_game
    puts "Unfortunately you have run out of attempts to guess the word. Just so you know, the word that you were trying to guess was #{@word}! Would you like to play again?"
    puts "\n"
    play_again
  end

  def won_game
    puts "Congratulations! You have won the game by guessing the word #{@word}! Would you like to play again?"
    puts "\n"
    play_again
  end

  def play_again
    puts 'Type "Y" or "N".'
    puts "\n"
    answer = gets.chomp.downcase

    if answer == 'y'
      puts 'Yay, another game!'
      puts "\n"
      game = Main.new
      game.prepare_game(game)
      prepare_game
    else
      puts 'Thanks for playing!'
      exit
    end
  end

end

game = Main.new
game.prepare_game(game)