puts "Введите коофициент a"
factor_a = gets.to_f
puts "Введите коофициент b"
factor_b = gets.to_f
puts "Введите коофициент c"
factor_c = gets.to_f
discr = ((factor_b**2) - (4 * factor_a * factor_c))
if discr < 0
  puts "Дискриминант = #{discr} Корней нет."
elsif discr > 0
  square_root = Math.sqrt(discr)
  x1 = (-factor_b + square_root) / (2.0 * factor_a)
  x2 = (-factor_b - square_root) / (2.0 * factor_a)
  puts "Дискриминант = #{discr} Корень1 = #{x1} Корень2 = #{x2}"
else #discr = 0
  square_root = Math.sqrt(discr)
  x1 = (-factor_b + square_root) / (2.0 * factor_a)
  puts "Дискриминант = #{discr} Корень = #{x1}"
end

