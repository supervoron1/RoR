fibo = [0, 1]

while (value = fibo.last + fibo[-2]) < 100 do
	fibo << value
end

puts fibo

