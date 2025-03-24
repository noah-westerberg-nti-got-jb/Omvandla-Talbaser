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

def convert_base(num_string, old_base, new_base, max_decimal_places)
  if num_string[0] == "."
    num_string = "0" + num_string 
  end
  split_num = num_string.split(".")
  
  integer_string = split_num[0]
  integer = 0
  integer_string.each_char do |char|
    integer = integer * old_base + char_to_num(char)
  end

  decimal = 0.0
  if split_num[1]
    split_num[1].reverse.each_char do |char|
      decimal = decimal / old_base + char_to_num(char)
    end
    decimal /= old_base
  end

  num = integer += decimal

  integer_length = 0
  while new_base ** integer_length < integer
    integer_length += 1
  end

  new_num_length = integer_length

  num_array = []
  while new_num_length >= -(max_decimal_places + 1)
    position_number = (num / (new_base ** new_num_length)).to_i
    num_array.append(position_number)
    num -= position_number * (new_base ** new_num_length)
    new_num_length -= 1
  end

  if num_array[-1] >= new_base / 2
    num_array[-2] += 1
    num_array[-1] = 0
  end

  i = 0
  while i < num_array.length
    if num_array[i] >= new_base
      num_array[i-1] += 1
      num_array[i] = 0
      i -= 1
      next
    end

    i += 1
  end

  result = ""
  i = 0
  while i < (num_array.length - 1) || i <= integer_length
    if num_array.length > integer_length && i == integer_length
      result += num_to_char(num_array[i]) + "."
    elsif i >= (num_array.length - 1)
      result += "0"
    else
      result += num_to_char(num_array[i])
    end
    i += 1
  end

  result = result[1..-1] while result[0] == "0" && result[1] != "."
  if result.include?(".")
    result = result[0..-2] while result[-1] == "0"
    result = result[0..-2] if result[-1] == "."
  end

  return result
end

def main
  base1 = 10
  base2 = 10
  precission = 3
  num = nil

  while true
    puts "Number-base Converter"
    puts "(I) Input base: #{base1}; (O) Output base: #{base2}; (P) Precission: #{precission}; (Q) Quit"

    input = gets.chomp
    if input.downcase == ":q"
      return
    elsif input.downcase == ":i"
      puts "Enter a new integer base from 1 - 62"
      base1 = gets.chomp.to_i
      puts "\n\n"
    elsif input.downcase == ":o"
      puts "Enter a new integer base from 1 - 62"
      base2 = gets.chomp.to_i
      puts "\n\n"
    elsif input.downcase == ":p"
      puts "Enter the precission (numbers after the decimal point)"
      precission = gets.chomp.to_i
      puts "\n\n"
    elsif input != ""
      num = input
      converted = convert_base(num, base1, base2, precission)
      puts "base(#{base1}) #{num} is #{converted} in base(#{base2})"
    end   
  end

  converted_number = convert_base(num, base1.to_i, base2.to_i)
  puts "base(#{base1}): #{num} is #{converted_number} in base(#{base2})"
end

main