class Route
  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
     @first_station = first_station
     @last_station = last_station
     @stations = []
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
end
