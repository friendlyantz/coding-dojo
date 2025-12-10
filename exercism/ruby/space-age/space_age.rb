class UnknownPlanet < NoMethodError
  def initialize(message = 'we are not aware of this orbit details')
    super
  end
end

class SpaceAge
  seconds_on_earth = 31_557_600

  ORBITAL_PERIOD = {
    mercury: Rational(0.2408467, 1),
    venus: Rational(0.61519726, 1),
    earth: 1r,
    mars: Rational(1.8808158, 1),
    jupiter: Rational(11.862615, 1),
    saturn: Rational(29.447498, 1),
    uranus: Rational(84.016846, 1),
    neptune: Rational(164.79132, 1)
  }.transform_values { _1 * seconds_on_earth }

  private

  def initialize(seconds)
    @seconds = seconds
  end


  def method_missing(method_name, *args, &block)
    if method_name.to_s.start_with?('on_')
      raise UnknownPlanet unless aware_of_orbit?(method_name)

      planet_name = get_planet_name(method_name)
      self.class.define_method(method_name) do
        @seconds / ORBITAL_PERIOD[planet_name]
      end
      send(method_name)
    else
      super
    end
  end


  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('on_') &&
    aware_of_orbit?(method_name) ||
    super
  end

  def aware_of_orbit?(method_name)
    ORBITAL_PERIOD.key?(get_planet_name(method_name))
  end

  def get_planet_name(method_name)
    method_name.to_s.delete_prefix('on_').to_sym
  end
end
