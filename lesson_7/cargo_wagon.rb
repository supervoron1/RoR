class CargoWagon < Wagon

  attr_accessor :taken_volume, :free_volume

  def initialize(number, capacity)
    super(number, capacity, :cargo)
    @taken_volume = 0
  end

  def take_volume(volume)
    @taken_volume += volume

    puts @taken_volume
    puts self.free_volume
  end

  def free_volume
    @capacity - @taken_volume
  end

  def has_free_volume?
    self.free_volume.positive?
  end


end
