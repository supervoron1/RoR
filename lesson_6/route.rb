require_relative 'instance_counter'

class Route
  include InstanceCounter
  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    validate!(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
    register_instance
  end

  def valid?
    valid!
    true
  rescue StandardError
    false
  end

  def add_station(station)
    return if [@first_station, @last_station].include?(station)
    @stations.push(station)
  end

  def remove_station(station)
    return if [@first_station, @last_station].include?(station)
    @stations.delete(station)
  end

  def stations
    [@first_station, *@stations, @last_station]
  end

  protected

  def validate!(first_station, last_station)
    raise 'Не задана начальная станция! Попробуйте еще раз.' if first_station.nil?
    raise 'Не задана конечная станция! Попробуйте еще раз.' if last_station.nil?
    raise 'Начальная и конечная станции не должны быть одинаковыми' if first_station == last_station
    #raise 'Сначала создайте маршрут! ===>' if @route.nil?
  end
end
