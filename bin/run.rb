require_relative '../lib/get_user_input.rb'
require_relative '../lib/parse_twitch.rb'

# Twitch.configure do |config|
#   config.client_id = '########### MISSING CLIENT ID #############'
# end

channels = get_channels
num = get_num_of_games
output_basic_info(channels)
games_and_players(num)
