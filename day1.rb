#!/usr/bin/ruby
# coding: utf-8

# Day 1: The Tyranny of the Rocket Equation
module Day1
  class RocketModule
    attr_reader :mass
    @@modules = []

    def initialize(mass)
      @mass = mass
      @@modules << self
    end

    def fuel_required
      self.class.fuel_required @mass
    end

    # Also account for the fuel necessary for the fuel's mass.
    def total_fuel_required
      # A 2.7-ism. Requires bleeding-edge Ruby. Like from the HEAD.
      Enumerator.produce(fuel_required) { |remaining|
        self.class.fuel_required remaining
      }.take_while { |f| f > 0 }.sum
    end

    def self.modules
      return @@modules
    end

    # ⌊ mass ÷ 3 ⌋ - 2
    def self.fuel_required(mass)
      return (mass / 3).floor - 2
    end
  end

  # The goal is to keep these tasks individually executable, hence the
  # input processing going in the top level.
  STDIN.read.split("\n").each do |mass|
    RocketModule.new(Integer(mass))
  end

  # Part 1: To launch, the total amount of fuel required will need to
  # be crunched according to the Fuel Counter-Upper.  
  def self.part1
    return RocketModule.modules.sum(&:fuel_required)
  end

  # Now the Rocket Equation Double-Checker decided to speak up!
  # Turns out the fuel being sent up is also mass that needs to be
  # accounted for with fuel.
  # Likewise, THAT fuel is also mass to be accounted for.
  # Keep adding fuel for the fuel until we got enough.
  def self.part2
    return RocketModule.modules.sum(&:total_fuel_required)
  end
end

puts "Day 1: The Tyranny of the Rocket Equation"
puts "  Part 1: #{Day1.part1}"
puts "  Part 2: #{Day1.part2}"
