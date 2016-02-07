class Question
  attr_reader :ques, :correct_answer

  def initialize 
    @correct_answer = nil
    @operator = ["+", "-", "*", "/"]
  end

  # A String is generated, which is used as the question.
  # Always returns a String.
  def generate_question
    generate_numbers
    generate_operator
    generate_answer
    "What does #{@num1} #{@operator[@num3]} #{@num2} equal? "
  end

  def generate_numbers
    @num1 = rand(1..20)
    @num2 = rand(1..20)
  end

  # One random Integer is generated, which is used to select the operator.
  # Always returns a Integer.
  def generate_operator
    @num3 = rand(0..3)
  end

  # The correct answer to the generated question is calculated.
  # Always returns a Integer.
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
