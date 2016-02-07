require 'pry'
require 'colorize'
require_relative 'question' 

class Player
  attr_reader :lives, :score, :total_score
  attr_accessor :name, :answer
  
  def initialize ()
    @name = ""
    @total_score = 0
    reset
  end 
  
  # Reset the lives, score and answer for any instance of the Player object.
  # Always returns an empty String.
  def reset
    @lives = 3
    @score = 0
    @answer = ""
  end

  # Increments the score for any instance of the Player object.
  # Always returns a Integer.
  def gain_points
    @score += 1
  end

  # Decrements the score for any instance of the Player object.
  # Always returns a Integer.
  def lose_life
    @lives -= 1
  end

  # Updates the total score for any instance of the Player object.
  # Always returns a Integer.
  def update_total_score
    @total_score += @score
  end
end


class Game

  def initialize
    @players = [Player.new, Player.new]
    @current_player = @players[0]
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

  # Prompts the player to give an answer.
  # Returns the answer(Integer) given by the player.
  # Always returns an Integer.
  def prompt_player_for_answer
    print "\n#{@current_player.name} : " + @question.generate_question
    @current_player.answer = gets.chomp.to_i
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

  # Verifies the answer given by player with the correct answer.
  # Always returns a Boolean.
  def verify_answer?()
    @current_player.answer == @question.correct_answer
  end

  # Updates the score and life of the players..
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

  # Switches between two players.
  # Always returns a Player Object.
  def switch_player
    if @current_player == @players[0]
      @current_player = @players[1]
    else
      @current_player = @players[0]
    end
  end

  def start_game
    print "Let's Play the Two Player Math Game.\n".green

    ask_names
    @question = Question.new
    choice = 'y'
  
    while choice == 'y'
      @players[0].reset 
      @players[1].reset
      while @players[0].lives > 0 && @players[1].lives > 0
          prompt_player_for_answer
          update_player_status
          switch_player
      end
      @players.each { |player| player.update_total_score }
      display_winner
      print "Do you want to play again?(y/n): "
      choice = gets.chomp.downcase
    end
  end
end

new_game = Game.new()

new_game.start_game
