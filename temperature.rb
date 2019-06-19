require 'open-uri'
require 'nokogiri'
require 'twitter'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

#天気が載っているサイト
forcastSite = 'https://weathernews.jp/onebox/33.59/130.40/temp=c&q=%E7%A6%8F%E5%B2%A1%E7%9C%8C%E7%A6%8F%E5%B2%A1%E5%B8%82%E4%B8%AD%E5%A4%AE%E5%8C%BA&v=23beae6038d8b2acd18061c53e1d0fcb08a564f84a2dd6e6ce361b8a9b673a29'

def getTemperature(url)
	temperature = Nokogiri.HTML(open(url)).xpath('////div[@class="text_box"]/table[@class="table-obs_main"]//span[@class="obs_temp_main"]').text
	temperature
end

def getTime(url)
	time = Nokogiri.HTML(open(url)).xpath('////div[@class="text_box"]/span[@class="sub"]').text.split(",")[0]
	time
end

def tweet(text)
	@client.update(text)
end

text = getTime(forcastSite) + 'の福岡市中央区の気温は' + getTemperature(forcastSite) + '℃です。'

# tweet(text)

puts text
