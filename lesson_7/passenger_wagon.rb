class PassengerWagon < Wagon

  def initialize(number, capacity)
    super(number, capacity, :'passenger')
  end

  def take_seat
    @taken_volume += 1
  end

end
