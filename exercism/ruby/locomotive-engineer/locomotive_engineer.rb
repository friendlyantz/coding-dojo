require 'pry'

class LocomotiveEngineer
  def self.generate_list_of_wagons(*args)
    Array.new args
  end

  def self.fix_list_of_wagons(each_wagons_id, missing_wagons)
    first_two_wagons = each_wagons_id.shift(2)
    new_order = each_wagons_id + first_two_wagons
    new_order.insert(1, *missing_wagons)
  end

  def self.add_missing_stops(itenary, *args)
    # itenary[:stops] = args[1].values # this is too easy as per description????

    itenary[:stops] = []

    return itenary if args.nil?

    args.each do |hash|
      itenary[:stops] += hash.values
    end
    itenary
  end

  def self.extend_route_information(route, more_route_information)
    # route.merge more_route_information # again this is too easy, and we need to implement unpacking

    more_route_information.each do |key, value|
      route[key] = value
    end
    route
  end
end
