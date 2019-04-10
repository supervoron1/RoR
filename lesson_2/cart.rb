cart = {}

loop do
  puts "Введите название товара или СТОП для завершения"
  item_name = gets.chomp
  break if item_name.downcase == "стоп" || item_name.downcase == "stop"
  puts "Введите цену"
  price = gets.to_f
  puts "Введите количество"
  quantity = gets.to_f

  cart[item_name] = { price: price, quantity: quantity}
end

puts cart

total_amount = 0

cart.each do |item_name, item|
  item_total = item[:quantity] * item[:price]
  puts "#{item_name} на сумму #{item_total}"
  total_amount += item_total
end

puts "Всего на сумму: #{total_amount}"
