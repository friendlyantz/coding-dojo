class Microwave
  attr_reader :time

  def initialize(time)
    @time = time
  end

  def timer
    if time.to_s.size <= 2
      min, sec = time.divmod(60)
    else
      min, sec = time.to_s[0...-2].to_i, time.to_s[-2..-1].to_i
      if sec >= 60
        min += 1
        sec = sec % 60
      end
    end
    "#{format_time(min)}:#{format_time(sec)}"
  end

  def format_time(number)
    format('%02d', number)
  end
end
