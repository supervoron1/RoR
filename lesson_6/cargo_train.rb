class CargoTrain < Train

  def initialize(number)
    super(number, :cargo)
    #@type = 'cargo'  #passed it to parent class via symbol
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end

end
