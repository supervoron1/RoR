class CargoTrain < Train
  
  def initialize(number)
    super
    @type = 'cargo'
    validate!
  end
  
  def attachable_wagon?(wagon)
  	wagon.is_a?(CargoWagon)
  end

end
