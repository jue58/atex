require 'redis'
require 'json'
require 'discordrb'

redis = Redis.new(host: 'redis')

name_list = redis
  .lrange('roster', 0, -1)
  .map do |v|
    r = JSON.parse(v)
    r['name']
  end

p name_list

unless name_list.empty?
  roster = name_list.map{|v| "- #{v}\n"}.join
  message = <<EOS
今回の参加者

#{roster}
EOS
  bot = Discordrb::Bot.new(token: ENV['DISCORD_TOKEN'])
  bot.send_message(ENV['DISCORD_CHANNEL'], message)  
end

redis.del('roster')
