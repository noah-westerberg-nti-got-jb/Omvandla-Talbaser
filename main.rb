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

  new_num_length = -1
  while new_base ** new_num_length < integer
    new_num_length += 1
  end

  result = ""
  while new_num_length >= 0
    position_number = integer / new_base ** new_num_length
    result += num_to_char(position_number)
    integer %= new_base ** new_num_length
    new_num_length -= 1
  end

  result = result[1..-1] while result[0] && result.length > 1 == "0"

  if split_num[1]
    decimal = 0.0
    split_num[1].reverse.each_char do |char|
      decimal = decimal / old_base + char_to_num(char)
    end
    decimal /= old_base

    decimal_array = []
    new_num_length = 1
    while new_num_length <= max_decimal_places + 1
      position_number = (decimal / new_base ** -new_num_length).to_i

     puts "decimal: #{decimal}; new_base: #{new_base}; length: #{new_num_length}; pos_num: #{position_number}"

      decimal -= position_number * (new_base ** -new_num_length)
      
      decimal_array.append(position_number)

      new_num_length += 1
    end
    puts "dec_arr: #{decimal_array}"

    if decimal_array[decimal_array.length - 1] > new_base / 2
      decimal_array[max_decimal_places] += 1
    end

    puts "dec_arr: #{decimal_array}"
    i = 0
    while i < decimal_array.length
      if decimal_array[i] >= new_base
        decimal_array[i-1] += 1
        decimal_array[i] = 0
        i -= 1
        next
      end
      puts "dec_arr: #{decimal_array}; i: #{i}"

      i += 1
    end

    decimal_result = decimal_array.map {|num| num_to_char(num)}.join



    result += "." + decimal_result
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
    puts "(I) Input base: #{base1}; (O) Output base: #{base2}; (D) Decimal precission: #{precission}; (Q) Quit"

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
    elsif input.downcase == "d"
      puts "Enter the maximum number of decimal places"
      precission = gets.chomp.to_i
      puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    else
      num = input
      converted = convert_base(num, base1, base2, precission)
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