require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'station'
require_relative 'route'

class Main
  attr_reader :trains
  def initialize
    @menus = ["Создавать станции",
              "Создавать поезда",
              "Создавать маршруты и управлять станциями в нем (добавлять, удалять)",
              "Назначать маршрут поезду",
              "Добавлять вагоны к поезду",
              "Отцеплять вагоны от поезда",
              "Перемещать поезд по маршруту вперед и назад",
              "Просматривать список станций и список поездов на станции",
              "generate random data",
              "Выйти"]
    @stations = []
    @trains = []
    @routes = []
  end

  def puts_separator
    puts "-----------------------------------------------"
  end
  def puts_menus
    @menus.each_with_index { |menu, index| puts "#{index + 1} - #{menu}" }
  end
  def puts_stations
    puts "Список станций:"
    @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
  end

  def puts_trains
    puts "Список поездов:"
    @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.number}" }
  end

  def puts_routes
    puts "Список маршрутов:"
    @routes.each_with_index do |route, index|
      print "#{index + 1} - "
      route.stations.each_with_index { |station, station_index| print " -> " if station_index > 0; print station.name }
      print "\n"
    end
  end

  def start
    loop do
      puts_separator

      puts "Программа управления железной дороги:"
      puts_menus
      print "Введите число из меню: "
      selected_menu = gets.to_i

      break if selected_menu == (@menus.length)

      stations = []
      trains = []

      puts_separator

      if selected_menu == 1 # Создавать станции
        create_station

      elsif selected_menu == 2 # Создавать поезда
        create_train

      elsif selected_menu == 3 # Создавать маршруты и управлять станциями в нем (добавлять, удалять)
        create_route

      elsif selected_menu == 4 # Назначать маршрут поезду
        set_route_to_train

      elsif selected_menu == 5 # Добавлять вагоны к поезду
        add_wagon_to_train

      elsif selected_menu == 6 # Отцеплять вагоны от поезда
        remove_wagon_from_train

      elsif selected_menu == 7 # Перемещать поезд по маршруту вперед и назад
        move_train

      elsif selected_menu == 8 # Просматривать список станций и список поездов на станции
        browse_trains_in_station

      elsif selected_menu == 9 #generate random data
        generate_data

      end
    end
  end

  protected

  def create_station
    puts "Создать станцию:"
    print "Название: "
    station_name = gets.chomp

    @stations << Station.new(station_name)

    puts "Станция '#{station_name}' создана."
  end

  def create_train
    loop do
      puts "Создать поезд:"
      puts "1 - Пассажирский"
      puts "2 - Грузовой"
      print "Тип: "
      train_type = gets.to_i

      next unless [1, 2].include?(train_type)

      print "Номер поезда: "
      train_number = gets.chomp

      if train_type == 1
        @trains << PassengerTrain.new(train_number)

        puts "Пассажирский поезд '#{train_number}' создан."
      elsif train_type == 2
        @trains << CargoTrain.new(train_number)

        puts "Грузовой поезд '#{train_number}' создан."
      end

      break if [1, 2].include?(train_type)
    end
  end

  def create_route
    puts "Создать маршрут:"
    puts_stations
    print "Укажите маршрут от - до (в формате '1 - 2'): "
    route_from_to = gets.chomp.split(" - ")
    route_from = @stations[route_from_to[0].to_i - 1]
    route_to = @stations[route_from_to[-1].to_i - 1]
    route = Route.new(route_from, route_to)

    puts "Маршрут '#{route_from.name} - #{route_to.name}'."

    loop do
      puts "1 - Добавить промежуточную станцию"
      puts "2 - Удалить промежуточную станцию"
      puts "3 - Выйти"
      print "Выберите действие: "
      route_selected_menu = gets.to_i

      if route_selected_menu == 1
        change_stations_in_route(route, :add)
      elsif route_selected_menu == 2
        change_stations_in_route(route, :remove)
      elsif route_selected_menu == 3
        break
      end
    end

    @routes << route
  end

  def change_stations_in_route(route, action)
    if action == :add
      puts "Добавить промежуточную станцию:"
    elsif action == :remove
      puts "Удалить промежуточную станцию:"
    end

    station = choose_station

    if action == :add
      route.add_station(station)
    elsif action == :remove
      route.remove_station(station)
    end
  end

  def set_route_to_train
    puts "Назначить маршрут:"
    train = choose_train
    puts "Выбран поезд '#{train.number}'"

    route = choose_route

    train.route = route
    puts "Поезду '#{train.number}' задан маршрут."
  end

  def add_wagon_to_train
    wagon_action (:add)
  end

  def remove_wagon_from_train
    wagon_action (:remove)
  end

  def wagon_action(action)
    if action == :add
      puts "Добавить вагон к поезду:"
    elsif action == :remove
      puts "Отцепить вагон от поезда:"
    end

    train = choose_train

    if action == :add
      if train.type == :passenger
        wagon = PassengerWagon.new
      elsif train.type == :cargo
        wagon = CargoWagon.new
      end

      train.add_wagon(wagon)

    elsif action == :remove
      train.remove_wagon
    end
  end

  def move_train
    puts "Переместить поезд по маршруту:"
    train = choose_train

    puts "1 - Вперед"
    puts "2 - Назад"
    print "Выберите действие: "
    train_action = gets.to_i

    if train_action == 1
      train.move_to_next_station
    elsif train_action == 2
      train.move_to_prev_station
    end
  end

  def browse_trains_in_station
    puts "Список станций и список поездов на станции:"
    station = choose_station

    puts "Список поездов на станции '#{station.name}':"
    station.trains.each_with_index { |train, index| puts "#{index + 1} - #{train.number}" }
  end

  def choose_station
    puts_stations
    print "Выберите станцию из списка: "
    @stations[gets.to_i - 1]
  end

  def choose_train
    puts_trains
    print "Выберите поезд из списка: "
    @trains[gets.to_i - 1]
  end

  def choose_route
    puts_routes
    print "Выберите маршрут из списка: "
    @routes[gets.to_i - 1]
  end

  def generate_station
    @stations << Station.new('moscow')
    @stations << Station.new('samara')
    @stations << Station.new('penza')
  end
  def generate_train
    @trains << PassengerTrain.new('pass_rapid01')
    @trains << PassengerTrain.new('pass_msk02')
    @trains << CargoTrain.new('cargo_rapid999')
  end
  def generate_data
    generate_station
    generate_train
  end

end

rr = Main.new
rr.start
