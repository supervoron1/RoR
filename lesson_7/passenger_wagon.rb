class PassengerWagon < Wagon

  def initialize(number, capacity)
    super(number, capacity, :'passenger')
    #@type = 'passenger'
    @taken_seats = 0
  end

  def take_seat
    @taken_seats += 1

    #puts @taken_seats
    #puts self.free_volume
  end

  def free_volume
    @capacity - @taken_seats
  end

  def has_free_volume?
    self.free_volume.positive?
  end

end
