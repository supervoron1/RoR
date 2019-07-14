class PassengerTrain < Train

  def initialize(number)
    super
    @type = 'passenger'
    validate!
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end

end
