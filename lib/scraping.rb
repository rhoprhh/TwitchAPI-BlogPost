class Scraper
  attr_accessor :username, :url, :follower_count
  def initialize(username)
    @username = username
    @url = 'https://api.twitch.tv/kraken/channels/'+username+'/follows'
    get_follower_num
  end

  def get_follower_num
    # file2 = '../TwitchAPI-BlogPost/data/dreamhack.html'
    # open(@url)
    # doc = Nokogiri::HTML(open(@url))
    # html2 = File.read(file2)
    # doc2 = Nokogiri::HTML(html2)
    string = RestClient.get(@url)
    hash = JSON.parse(string)
    @follower_count = hash["_total"]
  end
end
