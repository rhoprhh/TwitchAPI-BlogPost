require 'pry'
require 'kappa'

#######After you have been authenticated to the app, then the following commands can be run.

def output_basic_info(channel_names)
  channel_names.each do |x|
    channel = Twitch.channels.get(x)
    user = Twitch.users.get(x)
    puts "===========USER - #{user.display_name}================="
    puts "Username is #{user.name} and it is displayed as #{user.display_name}"
    puts "They are following #{user.following.count} people"# and being followed by #{channel.followers.length}."
    puts "Their account was created at #{user.created_at}"
    puts "The most recent game they played on stream was #{channel.game_name} with a stream title of '#{channel.status}'"
    puts "#{user.display_name} is being followed by #{channel.followers(:limit => 99).length}."
    puts ""
    puts ""
  end
end

#Gives the top 10 games, number of people watching and on how many channels.
def games_and_players(num)
  games = Twitch.games.top(:limit => num)
  games.each do |x|
    streamers = []
    x.streams(:limit => 5).each do |yy|
      streamers << yy.channel.display_name
    end
    streamers.insert(4, 'and')
    puts "=================GAME - #{x.name}====================="
    puts "#{x.name} has #{x.viewer_count} viewers on #{x.channel_count} channels"
    puts "That is an average of " + (x.viewer_count/x.channel_count).to_s + " per channel."
    print "The top 5 streamers of this game are currently: "
    streamers.each {|y| print "#{y} "}
    puts ""
    puts ""
    puts ""
  end
end
