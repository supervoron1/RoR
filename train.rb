class Train
  attr_reader :speed, :route, :number, :wagons, :type

  def initialize(number)
    @number = number
    @speed = 0
    @type = type
    @wagons = []
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

  def add_wagon(wagon)
    return unless speed.zero?
    return unless attachable_wagon?(wagon)
    @wagons << wagon
  end

  def remove_wagon(wagon)
    return unless speed.zero?
    @wagons.delete(wagon)
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

  protected

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def prev_station
    return unless @current_station_index > 0
    @route.stations[@current_station_index - 1]
  end

end
