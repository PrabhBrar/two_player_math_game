require 'pry'
require 'colorize'

# Resets the score, lives and the count of the questions asked.
def reset
  @player1_lives = 3
  @player2_lives = 3
  @player1_score = 0
  @player2_score = 0
  @count = 0
end

@player1_total_score = 0
@player2_total_score = 0

@operator = ["+", "-", "*"]
@random = Random.new

# Prompts the users to enter their names.
# Also gets their name and stores them in a variable.
def ask_names
  puts "Player 1, please enter your name : "
  @player1_name = gets.chomp
  puts "Player 2, please enter your name : "
  @player2_name = gets.chomp
end

# A String is generated, which is used as the question.
# Depending on the count, it decides if player 1 or player 2 will answer the question.
def generate_question
  @count += 1
  str = @count % 2 == 0 ? "#{@player2_name} : " : "#{@player1_name} : "
  @num1 = @random.rand(1..20)
  @num2 = @random.rand(1..20)
  @num3 = @random.rand(0..2)
  str += "What does #{@num1} #{@operator[@num3]} #{@num2} equal?"
end

# The correct answer to the generated question if calculated.
def generate_answer
  case @operator[@num3]
  when "+"
    @num1 + @num2
  when "-"
    @num1 - @num2
  when "*"
    @num1 * @num2
  end
end

# Prompts the player to give an answer.
# Also returns the answer given by the player.
def prompt_player_for_answer(str)
  puts "\n" + str
  user_input = gets.chomp.to_i
end

# The answer given by player and the correct answer to the question are passed as arguments
# If both are same then score is incremented for the player who was asked the question,
# else life is decremented for the same player.
# Always returns a boolean.
def verify_answer(answer, correct_answer)
  if answer == correct_answer
    @player1_score += 1 if @count % 2 != 0
    @player2_score += 1 if @count % 2 == 0
    true
  else
    @player1_lives -= 1 if @count % 2 != 0
    @player2_lives -= 1 if @count % 2 == 0
    false
  end
end

# This method displays the winner of each game along with the total score from the previous games.
def display_winner
  str = @player1_score > @player2_score ? "#{@player1_name} : " : "#{@player2_name} : "
  puts str + "won the game. #{@player1_name} score : #{@player1_score}   |   #{@player2_name} score : #{@player2_score}"
  puts "\n#{@player1_name}'s total score : #{@player1_total_score}   |   #{@player2_name}'s total score : #{@player2_total_score}"
end

# binding.pry
choice = 'y'
ask_names

while choice == 'y'
  reset
  while @player1_lives > 0 && @player2_lives > 0
    user_answer = prompt_player_for_answer(generate_question)
    correct_answer = generate_answer
    unless verify_answer(user_answer, correct_answer)
      puts "Wrong Answer!".red
      puts "#{@player1_name}'s score : #{@player1_score}   |   #{@player2_name}'s score : #{@player2_score}".blue
    else
      puts "Correct Answer. You get a cokkie!".green
    end
  end
  @player1_total_score += @player1_score
  @player2_total_score += @player2_score
  display_winner
  puts "Do you want to play again?(y/n)"
  choice = gets.chomp.downcase
end

puts "Thanks for playing!".red
