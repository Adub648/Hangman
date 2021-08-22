module SaveLogic
  def save_game
    puts "What is the ID of your game?"
    id = gets.chomp
    @loading_game = false
    show_saved_games(id)
  end

  def load_game
    @loading_game = true
    id = nil
    show_saved_games(id)
  end

  def show_saved_games(id)
    saved_games = ""
    # find and return file names
    Dir.foreach("saved_games") do |f|
      if f == "." || f == ".."
        next
      end
      saved_games += File.basename(f, ".*")
      saved_games += " "
    end
    if @loading_game == true
      if saved_games == ""
        puts "Unfortunately there are no saved games for you to play from and you will have to rejoin the current game that you are playing."
        puts "\n"
        @exempt = true
      else
        puts "Here are the games that are saved on this computer!"
        puts "\n"
        puts saved_games
        puts "\n"
        puts "What is the ID of the game that you would like to load?"
        id = gets.chomp
        id_validation(id, saved_games)
      end
    else
      id_validation(id, saved_games)
    end
  end

  def id_validation(id, saved_games)
    if saved_games.include?(id)
      if @loading_game == true
        unserialize_game(id)
      else
        puts "This id is already in use! Please use another ID."
        puts "\n"
        save_game
      end
    else
      if @loading_game == true
        puts "There are no saved games under that ID! Please try again."
        puts "\n"
        show_saved_games
      else
        serialize_game(id)
      end
    end
  end

  def serialize_game(id)
    obj = {}
    obj['id'] = id
    obj['user_guess'] = @user_guess
    obj['incorrect_guess'] = @incorrect_guess
    obj['word'] = @word
    obj['guesses_remaining'] = @guesses_remaining
    File.open("saved_games/#{id}.json", "w") { |f| f.write(JSON.dump(obj)) }
    @exempt = true
    puts "The game is now saved under #{id}!"
    puts "\n"
  end

  def unserialize_game(id)
    id += ".json"
    file = File.read("saved_games/#{id}")
    new_game = JSON.parse(file)
    @user_guess = new_game['user_guess']
    @word = new_game['word']
    @guesses_remaining = new_game['guesses_remaining']
    @incorrect_guess = new_game['incorrect_guess']
    @exempt = true
  end
end