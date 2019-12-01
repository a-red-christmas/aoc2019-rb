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

    # ⌊ mass ÷ 3 ⌋ - 2
    def fuel_required
      return (@mass / 3).floor - 2
    end

    def self.modules
      return @@modules
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
end

puts "Day 1: The Tyranny of the Rocket Equation"
puts "  Part 1: #{Day1.part1}"
