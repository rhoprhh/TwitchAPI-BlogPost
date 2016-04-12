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
      puts "=========== USER - #{user.display_name} ================="
      puts "Username is #{user.name} and it is displayed as #{user.display_name}"
      puts "They are following #{user.following.count} people"# and being followed by #{channel.followers.length}."
      puts "Their account was created at #{user.created_at}"
      puts "The most recent game they played on stream was #{channel.game_name} with a stream title of '#{channel.status}'"
      puts "#{user.display_name} is being followed by #{channel.followers(:limit => 99).length} accounts."
      puts ""
      puts ""
    end
  end
end

#Gives the top 10 games, number of people watching and on how many channels.
def games_and_players(num)
  average = []
  #gets top num games from list
  games = Twitch.games.top(:limit => num[0])
  games.each do |x|
    streamers = []
    streamer_display_names = []
    #get the top 5 streamers for each game
    x.streams(:limit => num[1]).each do |yy|
      streamers << yy.channel.name
      streamer_display_names << yy.channel.display_name
      #store display name here, use index later to call these names back
    end
    #output who top 5 are and their viewer count
    #streamers.insert(4, 'and')
    puts "================= GAME - #{x.name} ====================="
    puts "#{x.name} has #{x.viewer_count} viewers on #{x.channel_count} channels"
    puts "That is an average of " + (x.viewer_count/x.channel_count).to_s + " per channel."
    puts "The top 5 streamers of this game are currently: "
    total = 0
    streamers.each_with_index do |y,i|
      streams = Twitch.streams.get(y)
      puts "#{i+1}. #{streamer_display_names[i]} with #{streams.viewer_count} viewers."
      total += streams.viewer_count
    end
    total2 = (total.to_f/x.viewer_count.to_f*100).round(2)
    average << total2
    puts "They account for #{total2}% of the total viewship."
    3.times do puts "" end
  end
  total_avg = 0
  average.each do |x|
    total_avg += x
  end
  avg_percent = (total_avg / average.length).round(2)
  puts "That means for these games the top #{num[1]} streamers are responsible for"
  puts "an averge of #{avg_percent}% of the total viewership of their games."
  3.times do puts "" end
end
