¨
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

def main()
  puts "Enter the base of the input-number:"
  base1 = gets

  puts "Enter the base of the output-number:"
  base2 = gets


end