require 'pry'

def get_channels
  output = []
  puts "Add the name of the channels you would like to track 1 at a time."
  puts "When you have no more to add, please enter DONE"
  input = gets.chomp
  end_input = "DONE"
  until input.upcase == end_input
    output << input
    input = gets.chomp
  end
  puts ''
  puts ''
  puts ''
  output
end


def get_num_of_games
  input_int=0
  puts "Please enter the number of top games you want info about (limit 50)"
  input_string = gets.chomp
  input_int = input_string.to_i
  unless input_int < 50 && input_int > 0
    puts "invalid command, please try again"
    input_string = gets.chomp
    input_int = input_string.to_i
  end
  puts ''
  puts ''
  puts ''
  input_int
end
