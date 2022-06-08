require 'redis'
require 'mechanize'

agent = Mechanize.new


page = agent.get('https://wikiwiki.jp/nijisanji/Apex%20Legends%E3%81%BE%E3%81%A8%E3%82%81/%E3%83%97%E3%83%AC%E3%82%A4%E3%83%A4%E3%83%BCID%E3%81%BE%E3%81%A8%E3%82%81')
rows = page.css('div#content table tbody tr')
niji_list = rows.map do |v|
  [v.css(':nth-child(2)').text, v.css(':nth-child(1) a').text]
end

# 'id' => 'name',
stars = [
  # https://b-gamers.net/category/articles/game/apex/
  'RealSHAKAKINTV','釈迦(SHAKA/シャカ)',
]

redis = Redis.new(host: :redis)
redis.hmset(:stars, niji_list.flatten)
redis.hmset(:stars, stars)
