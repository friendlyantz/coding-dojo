class RobotSerial
  def initialize
    @serial = 'AA000'
  end

  def generate_name
    name = @serial.dup
    @serial.next!
    name
  end
end

class Robot
  attr_reader :name

  @@serializer = RobotSerial.new

  def initialize
    reset
  end

  def self.forget
    @@serializer = RobotSerial.new
  end

  def reset
    @name = @@serializer.generate_name
  end
end
