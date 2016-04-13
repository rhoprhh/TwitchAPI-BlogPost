require 'pry'
class Inputs
  attr_accessor :channels, :input_games, :input_streamers

  def initialize
    @channels=[]
    @input_streamers =0
    @input_games = 0
    run
  end

  def run
    puts ""
    puts "To see this menu again, type 'help'"
    puts "If you want to exit the app, type 'exit'"
    puts "If you would like data on specific channels please type 'channels'"
    puts "If you want info on the top games and their streams please type 'games'"
    puts ""
    input = gets.chomp.downcase
    case input
    when "help"
      run
    when "exit"
      exit
    when "channels"
      get_channels
    when "games"
      get_num_of_games_and_streamers
    else
      3.times do puts "" end
      puts "Please enter one of the following commands: help, exit, channels, games "
      run
    end
  end


  def get_channels
    puts "Add the name of the channels you would like to track 1 at a time."
    puts "When you have no more to add, please enter DONE"
    input = gets.chomp
    until input.upcase == "DONE"
      @channels << input
      input = gets.chomp
    end
    3.times do puts "" end
    output_basic_info(@channels)
  end


  def get_num_of_games_and_streamers
    #limit top#num of streams and top#games total to 50
    #include an input for getting how many streamers you want per game
    puts "Please enter the number of top games you want info about (limit 50 total entries (streamers * games))"
    @input_games = gets.chomp.to_i
    puts "Please enter the number of streamers per game:"
    @input_streamers = gets.chomp.to_i
    total = (@input_games * @input_streamers)
    unless total < 51 && total > 0
      puts "invalid command, please try again"
      puts "Please enter the number of top games you want info about (limit 50t otal entries (streamers * games))"
      input_games = gets.chomp.to_i
      puts "Please enter the number of streamers per game:"
      input_streamers = gets.chomp.to_i
      total = (@input_games * @input_streamers)
    end
    3.times do puts "" end
    games_and_players(@input_games, @input_streamers)
  end
end
