require 'pry'
require 'kappa'

#######After you have been authenticated to the app, then the following commands can be run.

def output_basic_info(channel_names)
  channel_names.each do |x|
    if Twitch.channels.get(x).nil?
      3.times do puts "#{x} is an invalid username" end
      3.times do puts "" end
    else
      channel = Twitch.channels.get(x)
      user = Twitch.users.get(x)
      follows_hash = Scraper.new(x)
      puts "=========== USER - #{user.display_name} ================="
      puts "Username is #{user.name} and it is displayed as #{user.display_name}"
      puts "They are following #{user.following.count} people"# and being followed by #{channel.followers.length}."
      puts "Their account was created at #{user.created_at}"
      puts "The most recent game they played on stream was #{channel.game_name} with a stream title of '#{channel.status}'"
      puts "#{user.display_name} is being followed by #{follows_hash.follower_count} accounts."
      puts ""
      puts ""
    end
  end
end

#Gives the top 10 games, number of people watching and on how many channels.
def games_and_players(num1, num2)
  average = []
  total_viewers_for_streamers = 0
  total_viewers_for_games = 0
  #gets top num games from list
  games = Twitch.games.top(:limit => num1)
  games.each do |x|
    streamers = []
    streamer_display_names = []
    #get the top 5 streamers for each game
    x.streams(:limit => num2).each do |yy|
      streamers << yy.channel.display_name
      streamer_display_names << yy.channel.display_name
      #store display name here, use index later to call these names back
    end
    #output who top 5 are and their viewer count
    puts "================= GAME - #{x.name} ====================="
    puts "#{x.name} has #{x.viewer_count} viewers on #{x.channel_count} channels"
    puts "That is an average of " + (x.viewer_count/x.channel_count).to_s + " per channel."
    puts "The top 5 streamers of this game are currently: "
    single_game_total = 0
    streamers.each_with_index do |y,i|
      streams = Twitch.streams.get(y)
      follows_hash = Scraper.new(y)
      percent_watching = (streams.viewer_count.to_f/x.viewer_count.to_f*100).round(2)
      puts "#{i+1}. #{streamer_display_names[i]} with #{streams.viewer_count} viewers. ".ljust(40) + "That's #{percent_watching}% of the total viewers of this game watching this channel.".ljust(72) + "This channel has #{follows_hash.follower_count} followers"
      total_viewers_for_streamers += streams.viewer_count
      single_game_total += streams.viewer_count
    end
    total2 = (single_game_total.to_f/x.viewer_count.to_f*100).round(2)
    total_viewers_for_games += x.viewer_count
    puts ""
    puts "".rjust(45) + "They account for #{total2}% of the game's total viewer count."
    3.times do puts "" end
  end
  avg_percent = (total_viewers_for_streamers.to_f / total_viewers_for_games.to_f*100).round(2)
  puts "That means for these games the top #{num1} streamers are responsible for"
  puts "an averge of #{avg_percent}% of the total viewership of their games."
  3.times do puts "" end
end
