class Question
  attr_reader :ques, :correct_answer

  def initialize 
    @ques = ""
    @correct_answer = nil
    @operator = ["+", "-", "*", "/"]
  end

  # A String is generated, which is used as the question.
  # Depending on the count, it decides if player 1 or player 2 will answer the question.
  def generate_question
    @num1 = rand(1..20)
    @num2 = rand(1..20)
    @num3 = rand(0..3)
    @ques = "What does #{@num1} #{@operator[@num3]} #{@num2} equal?"
  end

  # The correct answer to the generated question if calculated.
  def generate_answer
    @correct_answer = case @operator[@num3]
                      when "+"
                        @num1 + @num2
                      when "-"
                        @num1 - @num2
                      when "*"
                        @num1 * @num2
                      when "/"
                        @num1 / @num2
                      end
  end
end