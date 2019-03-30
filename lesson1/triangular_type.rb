puts "Введите длину стороны 1"
side1 = gets.to_i
puts "Введите длину стороны 2"
side2 = gets.to_i
puts "Введите длину стороны 3"
side3 = gets.to_i
cathetus1, cathetus2, hypotenuse =
  [side1, side2, side3].sort!
triangle_exists = cathetus1 + cathetus2 > hypotenuse
abort('Tреугольник не существует') unless triangle_exists
right_triangle = cathetus1**2 + cathetus2**2 == hypotenuse**2
if right_triangle && side1 == side2
  puts "Прямоугольный, Равнобедренный треугольник"
elsif right_triangle
  puts "Прямоугольный треугольник"
elsif side1 == side3
  puts "Pавносторонний, равнобедренный но не прямоугольный треугольник"
else
  puts "Треугольник не прямоугольный"
end
