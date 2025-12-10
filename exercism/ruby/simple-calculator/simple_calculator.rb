class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  def self.calculate(first_operand, second_operand, operation)
    raise SimpleCalculator::UnsupportedOperation unless first_operand && second_operand && operation

    raise ArgumentError unless first_operand.is_a?(Integer) && second_operand.is_a?(Integer)

    raise SimpleCalculator::UnsupportedOperation unless ALLOWED_OPERATIONS.include?(operation)

    return 'Division by zero is not allowed.' if first_operand.zero? || second_operand.zero?

    result = first_operand.send(operation.to_sym, second_operand)

    "#{first_operand} #{operation} #{second_operand} = #{result}"
  end

  class UnsupportedOperation < StandardError
  end
end
