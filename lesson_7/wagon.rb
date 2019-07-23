require_relative 'manufacturer'

class Wagon
  include Manufacturer

  attr_accessor :capacity, :taken_volume
  attr_reader :number, :type

  WAGON_CAPACITY_ERROR = 'Не задан объем вагона!'
  WAGON_NUMBER_ERROR = 'Не задан номер вагона!'
  WAGON_NUM_FORMAT = /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i

  def initialize(number, capacity, type)
    @type = type
    @capacity = capacity
    @number = number
  end

end
