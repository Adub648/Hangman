module GameLogic
  def validate_response(input)
    if input == "SAVE"
      save_game
    elsif input == "LOAD"
      load_game
    elsif input == "EXIT"
      puts "Thanks for playing!"
      exit
    elsif input.match(/^[A-Za-z]$/) == nil
      puts "You have entered an incorrect input! The required input is one character from a-z. Please try again."
      puts "\n"
      return
    elsif @incorrect_guess.include?(input)
      puts "You have already entered in this character! Please try again."
      puts "\n"
      return
    end
    check_response(input)
    if @user_guess == @word
      @word = @word.join("")
      won_game
    end
    puts "\n"
    format_guesses
    # avoids other inputs counting as incorrect guesses
    if @exempt == true
      @exempt = false
    end
  end

  def check_response(input)
    if @exempt == false
      input = input.downcase
      if @word.include?(input)
        # checking against answer and inputting correct letters into array
        @word.each_with_index do |v, i|
          if @word[i] == input
            @user_guess[i] = input
          end
        end
      else
        @incorrect_guess << input
        @guesses_remaining -= 1
      end
    end
  end

  def format_guesses
    formatted_guess = []
    @user_guess.each_with_index do |v, i|
      if v == ""
        formatted_guess << "_"
      else
        formatted_guess << @user_guess[i]
      end
    end
    puts formatted_guess.join('')
    puts "\n"
  end
end