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
  base1 = 10
  base2 = 10
  num = nil

  while true
    puts "Number-base Converter"
    puts "(I) Input-base: #{base1}; (O) Output-base #{base2}; (Q) Quit"

    input = gets.chomp
    if input.downcase == "q"
      return
    elsif input.downcase == "i"
      puts "Enter a new integer base from 1 - 62"
      base1 = gets.chomp.to_i
      puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    elsif input.downcase == "o"
      puts "Enter a new integer base from 1 - 62"
      base2 = gets.chomp.to_i
      puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    else
      num = input
      converted = convert_base(num, base1, base2)
      puts "base(#{base1}) #{num} is #{converted} in base(#{base2})"
      puts "\n\nPress any key to continue"
      gets
      puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    end   
  end

  converted_number = convert_base(num, base1.to_i, base2.to_i)
  puts "base(#{base1}): #{num} is #{converted_number} in base(#{base2})"
end

main