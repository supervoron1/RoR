class CargoWagon < Wagon

  def initialize(number, capacity)
    super(number, capacity, :cargo)
  end

end
