require 'pry'
require 'colorize'
require_relative 'question'
require_relative 'player'

class Game

  def initialize
    @players = [Player.new, Player.new]
    @current_player = @players[0]
    @question = Question.new
  end

  # Prints the summary for the math game
  # and gets the choice from the user.
  # Then makes a decision of starting or ending the game.
  def summary
    puts "This is a Two Player Math Game.".green
    puts "Answer easy maths questions to prove your knowledge of maths.".green
    print "Do you want to play?(y/n): "
    get_choice
    start_or_end
  end

  # Prompts the users to enter their names.
  # Also gets their name and stores them in a variable.
  # Always returns a String.
  def ask_names
    print "Player 1, please enter your name : "
    @players[0].name = gets.chomp
    print "Player 2, please enter your name : "
    @players[1].name = gets.chomp
  end

  # Gets the choice from the user.
  def get_choice
    @choice = gets.chomp.downcase
  end

  # Checks the choice of the user.
  # Always returns a Boolean.
  def choice?
    @choice == 'y'
  end

  # Decides if the game has to be started or not.
  def start_or_end
    if choice?
      ask_names unless @players[0].name  && @players[1].name 
      start_game
    else
      end_game
    end
  end

  # Asks the user, if they want to continue the game or not
  # and gets the choice from the user.
  # Then makes a decision of re-starting or ending the game.
  def play_again
    print "Do you want to play again?(y/n): "
    get_choice
    start_or_end
  end

  # If game ends, a message is printed out for the user.
  def end_game
    puts "\nThank you, come again to play this interesting game."
  end

  # Starts the game, by resetting the scores and lives of the two players.
  # While both player have 1 or more lives, game continues.
  # Updates the total score for both the players.
  def start_game
    @players[0].reset 
    @players[1].reset
    while @players[0].lives > 0 && @players[1].lives > 0
      prompt_player_for_answer
      update_player_status
      switch_player
    end
    @players.each { |player| player.update_total_score }
    display_winner
    play_again
  end

  # Prompts the player to give an answer.
  # Returns the answer(Integer) given by the player.
  # Always returns an Integer.
  def prompt_player_for_answer
    print "\n#{@current_player.name} : " + @question.generate_question
    @current_player.answer = gets.chomp.to_i
  end

  # Verifies the answer given by player with the correct answer.
  # Always returns a Boolean.
  def verify_answer?
    @current_player.answer == @question.correct_answer
  end

  # Prints a String.
  # Always returns nil.
  def display_correct
    puts "#{@current_player.name}, Correct Answer. You gain a point.".green
  end

  # Prints a String.
  # Always returns nil.
  def display_wrong
    puts "#{@current_player.name}, Wrong Answer! You lost a life. The correct answer is : #{@question.correct_answer}".red
    puts "#{@players[0].name}'s score : #{@players[0].score}   |   #{@players[1].name}'s score : #{@players[1].score}".blue
  end

  # Updates the score and life of the players.
  # Always returns nil.
  def update_player_status
    if verify_answer?
      @current_player.gain_points
      display_correct
    else
      @current_player.lose_life
      display_wrong
    end
  end

  # Switches between two players.
  # Always returns a Player Object.
  def switch_player
    if @current_player == @players[0]
      @current_player = @players[1]
    else
      @current_player = @players[0]
    end
  end

  # This method displays the winner of each game along with the total score from the previous games.
  # Always returns nil.
  def display_winner
    if @players[0].score == @players[1].score
      str = "\n#{@players[0].name} and #{@players[1].name}, it's a draw. No one "
    elsif @players[0].score > @players[1].score
      str ="\n#{@players[0].name} "
    else
      str ="\n#{@players[1].name} "
    end
    puts str + "won the game. \n#{@players[0].name}'s score : #{@players[0].score}   |   #{@players[1].name}'s score : #{@players[1].score}"
    puts "#{@players[0].name}'s total score : #{@players[0].total_score}   |   #{@players[1].name}'s total score : #{@players[1].total_score}"
  end

end

Game.new.summary
