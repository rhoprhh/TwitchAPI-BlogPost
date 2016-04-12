require_relative "../config/environment.rb"

channels = get_channels
num = get_num_of_games_and_streamers
output_basic_info(channels)
games_and_players(num)
