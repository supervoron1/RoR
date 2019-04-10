#vowels = "аоэыуяеюи".split("")
#
#abc = {}
#("а".."я").to_a.each_with_index do |value, index|
#	vowels.each { |letter| abc[letter] = index + 1 if value == letter }
#end
#puts abc


vowels = %w(а о э ы у я е ю и)
vowels_indexes = {}

("а".."я").each.with_index do |letter, index|
  vowels_indexes[letter] = index + 1 if vowels.include? letter
end

puts vowels_indexes
    
