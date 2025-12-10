class AssemblyLine
  HOURLY_OUTPUT = 221

  MODULATOR = {
    1 => 1,
    2 => 1,
    3 => 1,
    4 => 1,
    5 => 0.9,
    6 => 0.9,
    7 => 0.9,
    8 => 0.9,
    9 => 0.8,
    10 => 0.77
  }
  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    HOURLY_OUTPUT * @speed * MODULATOR[@speed]
  end

  def working_items_per_minute
    (production_rate_per_hour / 60.0).floor
  end
end
