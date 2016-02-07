class Player
  attr_reader :lives, :score, :total_score
  attr_accessor :name, :answer
  
  def initialize ()
    @name = nil
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
