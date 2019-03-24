puts "Как Вас зовут?"
name = gets.chomp
puts "#{name}, привет! Какой твой рост?"
height = gets.to_i
puts "#{name}, привет! Какой твой вес?"
weight = gets.to_i
ideal = height-110
if weight <= ideal
  puts "Ваш вес уже оптимальный"
else
  puts "Ваш идеальный вес: #{height-110}"
end

