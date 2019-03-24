puts "Введите коофициент a"
factor_a = gets.to_i
puts "Введите коофициент b`"
factor_b = gets.to_i
puts "Введите коофициент c"
factor_c = gets.to_i
Discr = ((factor_b**2) - (4*factor_a*factor_c))
puts Discr
if Discr < 0
  puts "Дискриминант = #{Discr} Корней нет."
elsif Discr > 0
  x1 = (-factor_b + Math.sqrt(Discr))/ (2 * factor_a)
  x2 = (-factor_b - Math.sqrt(Discr))/ (2 * factor_a)
  puts "Дискриминант = #{Discr} Корень1 = #{x1} Корень2 = #{x2}"
else
  x1 = (-factor_b + Math.sqrt(Discr))/ (2 * factor_a)
  puts "Дискриминант = #{Discr} Корень = #{x1}"

end
