vowels = "аоэыуяеюи".split("")

abc = {}
("а".."я").to_a.each_with_index do |value, index|
	vowels.each { |letter| abc[letter] = index + 1 if value == letter }
end
puts abc

