require 'date'

class Meetup
  def initialize(month, year)
    @month = month
    @year = year
  end

  WEEKDAY_NUMS = {
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 7
  }

  DESCRIPTOR_DAY_NUMS = {
    first: 1,
    second: 8,
    third: 15,
    fourth: 22,
    last: -1,
    teenth: 13
  }

  def day(weekday, weekday_descriptor)
    date = Date.new(@year, @month, DESCRIPTOR_DAY_NUMS[weekday_descriptor])
    until date.cwday == WEEKDAY_NUMS[weekday]
      date = case weekday_descriptor
             when :last
               date.prev_day
             when :first, :second, :third, :fourth, :teenth
               date.next_day
             end
    end

    date
  end
end
