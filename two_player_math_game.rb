require 'pry'
require 'colorize'
require_relative 'question' 

class Player
  attr_reader :name, :lives, :score, :total_score
  
  def initialize (name)
    @name = name
    @total_score = 0
    reset
  end 
  
  # Reset the lives and score for any instance of the Player object.
  def reset
    @lives = 3
    @score = 0
  end

  # Increments the score for any instance of the Player object.
  def gain_points
    @score += 1
  end

  # Decrements the score for any instance of the Player object.
  def lose_life
    @lives -= 1
  end

  # Updates the total score for any instance of the Player object.
  def update_total_score
    @total_score += @score
  end
end


class Game
  # Prompts the users to enter their names.
  # Also gets their name and stores them in a variable.
  def ask_names
    @players =[]
    print "Player 1, please enter your name : "
    @players.push(Player.new(gets.chomp))
    print "Player 2, please enter your name : "
    @players.push(Player.new(gets.chomp))
  end

  # Prompts the player to give an answer.
  # Also returns the answer given by the player.
  def prompt_player_for_answer(str, player)
    print "\n#{player.name} : " + str
    gets.chomp.to_i
  end

  # This method displays the winner of each game along with the total score from the previous games.
  def display_winner
    if @players[0].score == @players[1].score
      str = "It's a draw. #{@players[0].name} and #{@players[1].name} both "
    elsif @players[0].score > @players[1].score
      str ="#{@players[0].name} "
    else
      str ="#{@players[1].name} "
    end
    puts str + "won the game. #{@players[0].name}'s score : #{@players[0].score}   |   #{@players[1].name}'s score : #{@players[1].score}"
    puts "#{@players[0].name}'s total score : #{@players[0].total_score}   |   #{@players[1].name}'s total score : #{@players[1].total_score}"
  end

  # binding.pry
  def start_game
    print "Do you want to play the Two Player Math Game(y/n): ".green
    choice = gets.chomp.downcase

    if choice == 'y'
      ask_names
      @question = Question.new
      @count = 0
    else
      puts "Come again later!".red 
    end
  
    while choice == 'y'
      @players[0].reset 
      @players[1].reset
      while @players[0].lives > 0 && @players[1].lives > 0
        @players.each do |player|
          @question.generate_question
          @question.generate_answer
          if self.prompt_player_for_answer(@question.ques, player) == @question.correct_answer
            player.gain_points
            puts "Correct Answer.".green
          else
            player.lose_life
            puts "Wrong Answer! The correct answer is : #{@question.correct_answer}".red
            puts "#{@players[0].name}'s score : #{@players[0].score}   |   #{@players[1].name}'s score : #{@players[1].score}".blue
          end
        end
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