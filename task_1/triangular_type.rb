puts "Введите длину стороны 1"
side1 = gets.to_i
puts "Введите длину стороны 2"
side2 = gets.to_i
puts "Введите длину стороны 3"
side3 = gets.to_i
puts "Имеем дело с: "
if side1 <=0 || side2 <=0 || side3 <=0 || side1++side2 <= side3 || side1++side3 <= side2 || side3++side2 <= side1
  puts "Несуществующим треугольником"
elsif side1==side2 && side1==side3 && side2==side3
  puts "Равносторонний"
elsif side1==side2 && side1 !=side3 || side2==side3 && side3 !=side1 || side1==side3 && side1 !=side2
  puts "Равнобедренный"
elsif (side1**2) == ((side2**2) + (side3**2)) || (side2**2) == ((side1**2) + (side3**2)) || (side3**2) == ((side2**2) + (side1**2))
  puts "Прямоугольный"
elsif puts "Неравносторонним, неравнобедренным и не прямоугольным треугольником ))"
  	
end
