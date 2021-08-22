module Display
  def display_info
    <<~HEREDOC
      Welcome to hangman!

      This is a guessing game, where you have to try and guess a 5-12 character long word that is picked at random from the dictionary.

      You can only guess one letter at a time and if you get it wrong, then that will reduce the amount of incorrect guesses you can make. If you guess 8 incorrect letters, you are out!

      Ready? Lets begin. Good luck!

    HEREDOC
  end
end