# Convert a character to a number
# 0-9 -> 0-9
# A-Z -> 10-35
# a-z -> 36-61
def char_to_num(char) 
  ascii = char.ord

  if ascii >= 65 && ascii <= 90
    # capital letters
    ascii -= 7
  elsif ascii >= 97 && ascii <= 122
    # small letters
    ascii -= 13
  end

  return ascii - 48
end

def num_to_char(num)
  return "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"[num]
end

def convert_base(num_string, old_base, new_base)
  num = 0
  num_string.each_char do |char|
    num = num * old_base + char_to_num(char)
  end

  new_num_length = 0
  while new_base ** new_num_length < num
    
    new_num_length += 1
  end

  result = ""
  while new_num_length >= 0
    position_number = num / new_base ** new_num_length
    result += num_to_char(position_number)
    num %= new_base ** new_num_length
    new_num_length -= 1
  end

  result = result[1..-1] if result[0] == "0"

  return result
end

def main
  puts "Enter the base of the input-number:"
  base1 = gets.chomp

  puts "Enter the base of the output-number:"
  base2 = gets.chomp

  puts "Enter the number you want to convert:"
  num = gets.chomp

  converted_number = convert_base(num, base1.to_i, base2.to_i)
  puts "base(#{base1}): #{num} is #{converted_number} in base(#{base2})"
end

while true
  main
  
  puts "press \"q\" to quit"
  break if gets.chomp.downcase == "q"
end