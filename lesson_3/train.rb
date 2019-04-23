class Train
  attr_reader :speed, :route, :wagons, :number, :type

  def initialize(number, type, wagons)
    @number = number
    @speed = 0
    @wagons = wagons
    @type = type
    @current_station_index = 0
  end

  def speed_up(speed)
    @speed += speed
  end

  def slow_down(speed)
    @speed -= speed
    @speed = 0 if @speed < 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    return unless @speed.zero?
    @wagons += 1
  end

  def remove_wagon
    return unless @speed.zero?
    @wagons -= 1 if @wagons > 0
  end

  def route=(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def move_to_next_station
    return unless next_station
    current_station.remove_train(self)
    next_station.add_train(self)
    @current_station_index += 1
  end

  def move_to_prev_station
    return unless prev_station
    current_station.remove_train(self)
    prev_station.add_train(self)
    @current_station_index -= 1
  end

  # def stat
  #   puts "Train № #{@number}, current speed: #{@speed}, type: #{@type}, number of wagons: #{@wagons}, current station: #{@current_station}"
  # end

  #protected

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def prev_station
    return unless @current_station_index > 0
    @route.stations[@current_station_index - 1]
  end

end
