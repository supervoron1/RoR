class Train
  attr_reader :speed, :route, :wagons, :number, :type, :current_station

  def initialize(number, type, wagons)
    @number = number
    @speed = 0
    @wagons = wagons
    @type = type
    @current_station_index = 0
  end

  def speed_up
    @speed += 5
  end

  def slow_down
    @speed -= 5 unless @speed == 0
  end

  def stop
    @speed = 0
  end

  def wagon_action(action)
    stop
    if action == :add
      @wagons += 1
    elsif action == :remove
      @wagons -= 1 unless @wagons == 0
    end
  end

  def set_route=(route)
  	return unless route.class == Route

    @route = route
    @current_station_index = 0
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def move_up
    return unless @route.stations.size > @current_station_index + 1
    move(next_station)
  end

  def move_back
    return unless @current_station_index > 0
    move(previous_station)
  end

  def move(to_station)
    @current_station.remove_train(self)
    to_station.add_train(self)
    @current_station = to_station
    @current_station_index = @route.stations.index(@current_station)
  end

  def stat
    puts "Train № #{@number}, current speed: #{@speed}, type: #{@type}, number of wagons: #{@wagons}, current station: #{@current_station}"
  end

  def
    locate
    puts "Current station: #{@current_station}"
  end

  #protected

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end

end
