class CargoWagon < Wagon

  def initialize(number, capacity)
    super(number, capacity, :cargo)
  end

  def take_volume(volume)
    @taken_volume += volume
  end

end
