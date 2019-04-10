#fibo = [0, 1]
#
#while (value = fibo.last + fibo[-2]) < 100 do
#	fibo << value
#end
#
#puts fibo

fibo = [0, 1]
next_number = 1

while next_number < 100
  fibo << next_number
  next_number = fibo[-1] + fibo[-2]
end

puts fibo

