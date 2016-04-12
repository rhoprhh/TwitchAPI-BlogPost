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
  #limit top#num of streams and top#games total to 50
  #include an input for getting how many streamers you want per game
  puts "Please enter the number of top games you want info about (limit 50 total entries (streamers * games))"
  input_string_1 = gets.chomp
  puts "Please enter the number of streamers per game:"
  input_string_2 = gets.chomp
  input_int_1 = input_string_1.to_i
  input_int_2 = input_string_2.to_i
  total = (input_int_2 * input_int_1)
  unless total < 76 && total > 0
    puts "invalid command, please try again"
    puts "Please enter the number of top games you want info about (limit 75)"
    input_string_1 = gets.chomp
    puts "Please enter the number of streamers per game:"
    input_string_2 = gets.chomp
    input_int_1 = input_string_1.to_i
    input_int_2 = input_string_2.to_i
    total = (input_int_2 * input_int_1)
  end
  3.times do puts "" end
  output = [input_int_1, input_int_2]
end
