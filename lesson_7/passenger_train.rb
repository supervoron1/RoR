class PassengerTrain < Train

  def initialize(number)
    super(number, :passenger)
    #@type = 'passenger'  #passed it to parent class via symbol
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end

end
