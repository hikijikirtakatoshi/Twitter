require 'twitter'

# アクセストークンなどを設定
@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

def show_timeline
  @client.home_timeline(count: 200, max_id: tweets.last.id-1).each do |tweet|
  	print "\e[31m"
    puts tweet.user.name
    print "\e[0m"
    puts tweet.text
    puts "------------------------------------"
  end
end


while() do
  show_timeline
  sleep(60)
end