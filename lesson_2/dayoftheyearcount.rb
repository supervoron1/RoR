loop do
  puts "Введите дату в формате (dd.mm.yyyy): "
  date = gets.chomp
  date_split = date.split('.')
  day = date_split[0].to_i
  month = date_split[1].to_i
  year = date_split[2].to_i


  if day < 1 || day > 31
    puts "Такого числа не существует"
  elsif month < 1 || month > 12
    puts "Такого месяца не существует"
  elsif year < 0 || year > 3000
    puts "Год должен быть в интервале от 0 до 3000"
    break
  end

  months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  months[1] = 29 if ((year % 4).zero? && year % 100 != 0) || (year % 400).zero?
  dayoftheyear = day + months.take(month - 1).sum

  break

  puts "Сейчас #{dayoftheyear}-й день #{year} года"

end
