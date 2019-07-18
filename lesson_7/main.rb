require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'station'
require_relative 'route'

class Main
  INDEX_ERROR = 'Вы ввели недопустимое значение. Попробуйте еще раз.'

  attr_reader :trains

  TRAIN_TYPE_MENU = ['Пассажирский', 'Грузовой']

  MENU_ITEMS = [
    "Создавать станции",
    "Создавать поезда",
    "Создавать маршруты",
    "Управлять станциями в маршруте (добавлять, удалять)",
    "Назначать маршрут поезду",
    "Добавлять вагоны к поезду",
    "Отцеплять вагоны от поезда",
    "Перемещать поезд по маршруту вперед и назад",
    "Просматривать список станций и список поездов на станции",
    "Посмотреть все станции, поезда и список созданных маршрутов",
    "generate random data",
    "Показать все станции как объекты (метод класса .all)",
    "Найти поезд по его номеру",
    "Выйти"
  ]

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def start
    loop do
      puts_separator
      puts "Программа управления железной дороги:"
      show_main_menu
      print "Выберите пункт меню: "
      selected_menu = gets.to_i
      break if selected_menu == (MENU_ITEMS.length)
      puts_separator
      case selected_menu
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then route_menu
      when 5 then set_route_to_train
      when 6 then add_wagon_to_train
      when 7 then remove_wagon_from_train
      when 8 then move_train
      when 9 then browse_trains_in_station
      when 10 then statistics
      when 11 then generate_data
      when 12 then show_all_stations
      when 13 then find_train_by_number
      when 14 then register
      end
    end
  end

  private

  def puts_separator
    puts "-----------------------------------------------"
  end

  def show_main_menu
    MENU_ITEMS.each.with_index(1) do |item, index|
      puts "#{index} - #{item}"
    end
  end

  def show_train_type_menu
    TRAIN_TYPE_MENU.each.with_index(1) do |item, index|
      puts "#{index} - #{item}"
    end
  end

  def puts_stations
    puts "Список станций:"
    if @stations.empty?
      puts "Пока не заданы"
    else
      @stations.each.with_index(1) do |station, index|
        puts "#{index} - #{station.name}"
      end
    end
  end

  def puts_trains
    puts "Список поездов:"
    if @trains.empty?
      puts "Пока не заданы"
    else
      @trains.each.with_index(1) do |train, index|
        puts "#{index} - №#{train.number} - Тип: #{train.type}"
      end
    end
  end

  def puts_routes
    puts "Список маршрутов:"
    if @routes.empty?
      puts "Пока не заданы"
    else
      @routes.each.with_index(1) do |route, index|
        route_stations = route.stations.map(&:name).join(' -> ')
        puts "#{index} - #{route_stations}"
      end
    end
  end

  def statistics
    puts_routes
    puts_stations
    puts_trains
  end

  def show_all_stations
    puts 'Созданы следующие объекты станций:'
    if Station.all.empty?
      puts 'Станции пока не созданы!'
      return
    end
    puts Station.all.map(&:name).join(', ')
  end

  protected

  def create_station
    puts "Создать станцию:"
    print "Название: "
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "Станция '#{station_name}' создана."
  rescue StandardError => e
    puts e
    retry
  end

  # def create_train    # METHOD'S BEEN REFACTORED
  #   loop do
  #     puts "Создать поезд:"
  #     puts "1 - Пассажирский"
  #     puts "2 - Грузовой"
  #     print "Тип: "
  #     train_type = gets.to_i
  #     next unless [1, 2].include?(train_type)
  #     print "Номер поезда: "
  #     train_number = gets.chomp
  #     if train_type == 1
  #       @trains << PassengerTrain.new(train_number)
  #       puts "Пассажирский поезд '#{train_number}' создан."
  #     elsif train_type == 2
  #       @trains << CargoTrain.new(train_number)
  #       puts "Грузовой поезд '#{train_number}' создан."
  #     end
  #     break
  #   end
  # rescue StandardError => e
  #   puts e
  #   retry
  # end

  def create_train
    puts_separator
    show_train_type_menu
    print 'Какой тип поезда хотите создать: '
    train_type = select_from_collection([PassengerTrain, CargoTrain])
    print "Номер поезда: "
    train_number = gets.chomp
    @trains << train_type.new(train_number)
    puts "Создан поезд №#{train_number}, Тип: #{train_type}"
  rescue StandardError => e
    puts e
    retry
  end

  def select_from_collection(collection)
    index = gets.to_i - 1
    raise INDEX_ERROR unless index.between?(0, collection.size - 1)
    collection[index]
  end

  def create_route
    if @stations.length >= 2
      puts_stations
      puts "Выберите начальную станцию"
      route_from = select_from_collection(@stations)
      puts "Выберите конечную станцию"
      route_to = select_from_collection(@stations)
      #return if route_from.nil? || route_to.nil?   # MADE VIA EXCEPTIONS
      #return if route_from == route_to
      @routes << Route.new(route_from, route_to)
      puts "Создан маршрут: #{route_from.name} -> #{route_to.name}."
    else
      puts 'Сначала создайте станции, чтобы создавать маршруты (не менее 2)'
    end
  rescue StandardError => e
    puts e
    retry
  end

  def route_menu
    loop do
      puts "1 - Добавить промежуточную станцию"
      puts "2 - Удалить промежуточную станцию"
      puts "3 - Выйти"
      print "Выберите действие: "
      route_menu_choice = gets.to_i

      case route_menu_choice
      when 1 then add_extra_station
      when 2 then remove_extra_station
      when 3 then break
      else puts "Простите, я Вас не понял"
      end
      puts_separator
    end
  end

  def add_extra_station
    if @routes.empty?
      puts "Сначала создайте маршрут!"
    else
      puts "Выберите маршрут для редактирования"
      route = choose_route
      puts "Введите номер станции которую вы хотите добавить в маршрут"
      station = choose_station
      route.add_station(station)
      puts "Добавлена станция #{station.name} в маршрут: #{route.stations.map(&:name).join(' -> ')}."
    end
  end

  def remove_extra_station
    if @routes.empty?
      puts "Сначала создайте маршрут!"
    else
      puts "Выберите маршрут для редактирования"
      route = choose_route
      puts "Введите номер станции которую вы хотите удалить из маршрута"
      station = choose_station
      route.remove_station(station)
      puts "Удалена станция #{station.name} из маршрута: #{route.stations.map(&:name).join(' -> ')}."
    end
  end

  def set_route_to_train
    puts "Назначить маршрут:"
    if @routes.empty? || @trains.empty?
      puts 'Сначала создайте маршрут и поезд!'
      return
    end
    train = choose_train
    puts "Выбран поезд '#{train.number}'"
    route = choose_route
    train.route = route
    puts "Поезду '#{train.number}' задан маршрут #{route.stations.map(&:name).join(' -> ')}."
  end

  def add_wagon_to_train
    if @trains.empty?
      puts "Сначала создайте поезд!"
      return
    end
    puts "Выберите поезд для работы"
    train = choose_train
    case train
    when CargoTrain
      train.add_wagon(CargoWagon.new)
    when PassengerTrain
      train.add_wagon(PassengerWagon.new)
    end
    puts "Добавлен вагон к поезду № #{train.number}, Тип - #{train.type}"
    puts "Теперь у поезда #{train.wagons.size} вагон/ов"
  end

  def remove_wagon_from_train
    if @trains.empty?
      puts "Сначала создайте поезд!"
      return
    end
    puts "Выберите поезд для работы"
    train = choose_train
    wagon = train.wagons.last
    train.remove_wagon(wagon)
    puts "Отцеплен вагон от поезда № #{train.number}, Тип - #{train.type}"
    puts "Теперь у поезда #{train.wagons.size} вагон/ов"
  end

  def move_train
    if @trains.empty?
      puts 'Сначала создайте поезд!'
      return
    end
    puts "Переместить поезд по маршруту:"
    train = choose_train

    if train.route.nil?
      puts "Поезду не присвоен маршрут!"
    else
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
  end

  def browse_trains_in_station
    puts "Список станций и список поездов на станции:"
    if @stations.empty?
      puts 'Станции пока не заданы'
      return
    end
    station = choose_station
    puts "Список поездов на станции '#{station.name}':"
    station.trains.each.with_index(1) { |train, index| puts "#{index} - #{train.number}, Тип - #{train.type}."}
  end

  def find_train_by_number
    puts 'Введите номер поезда'
    number = gets.chomp
    desired_train = Train.find_by_number(number)
    if desired_train == nil
      puts 'Поезда с таким номером не существует'
    else
      puts 'Поезд, который вы ищете:'
      puts "№ #{desired_train.number}, Тип: #{desired_train.type}"
      if desired_train.wagons == 0
        puts 'Прицепленных вагонов не имеет'
      else
        puts "Прицепленных вагонов: #{desired_train.wagons.size}, Тип вагона: #{desired_train.wagons.map(&:type)}"
      end
      if desired_train.route == nil
        puts 'Маршрут поезду не задан'
      else
        puts "Поезд на ходится на станции: #{desired_train.current_station.name}"
        puts "Маршрут следования: #{desired_train.route.stations.map(&:name).join(' -> ')}"
      end
    end
  end

  def choose_station
    puts_stations
    print "Выберите станцию из списка: "
    select_from_collection(@stations)
  rescue StandardError => e
    puts e
    retry
  end

  def choose_train
    puts_trains
    print "Выберите поезд из списка: "
    select_from_collection(@trains)
  rescue StandardError => e
    puts e
    retry
  end

  def choose_route
    puts_routes
    print "Выберите маршрут из списка: "
    select_from_collection(@routes)
  rescue StandardError => e
    puts e
    retry
  end

  def generate_station
    @stations << Station.new('moscow')
    @stations << Station.new('samara')
    @stations << Station.new('penza')
    @stations << Station.new('s.petersburg')
    @stations << Station.new('pskov')
  end

  def generate_train
    @trains << PassengerTrain.new('999-PS')
    @trains << PassengerTrain.new('555-PS')
    @trains << CargoTrain.new('777-CG')
  end

  def generate_data
    generate_station
    generate_train
    puts "Trains and Stations are randomly generated"
  end
end

rr = Main.new
rr.start
