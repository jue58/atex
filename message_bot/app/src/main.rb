require 'json'
require './lib/atex_db'
require './lib/discord_bot'

def get_roster(db)
  yield(db.get_roster.map{|v| JSON.parse(v)})
ensure
  db.del_roster
end

def format_name(p)
  p['encounter'] ? "#{p['name']} [#{p['encounter']}]" : p['name']
end

def send_roster(roster, bot)
  teams = roster.group_by{|v| v['team_id']}
  name_list = teams.map do |_, t|
    t.map {|p| format_name(p)}
  end

  unless name_list.empty?
    roster_str = name_list.map{|v| "- #{v.join(",  ")}\n"}.join
    message = <<EOS
----------------------------------------------------
今回の参加者

#{roster_str}
EOS
    bot.send_message(message)
  end
end

def send_stars(db, roster, bot)
  name_list = roster.map{|v| v['name']}
  matched_stars = db.match_stars(name_list)

  p "matched_stars: #{matched_stars}"    

  star_result = name_list.zip(matched_stars).to_h.compact
  unless star_result.empty?
    result_str = star_result.map{|k, v| "#{k} => #{v}\n"}.join
    message2 = <<EOS
----------------------------------------------------
もしかしたらこの人とマッチしてるかも...？

#{result_str}
EOS
    bot.send_message(message2)
  end
end

#################################################
# kokokara                                      #
#################################################
db = AtexDB.new

get_roster(db) do |roster|
  bot = DiscordBot.new(token: ENV['DISCORD_TOKEN'], channel: ENV['DISCORD_CHANNEL'])
  
  p "roster: #{roster}"

  unless roster.empty?
    roster.map do |v|
      num = db.increment_encounter(v['name'])
      v['encounter'] = num if num > 1
    end
    send_roster(roster, bot)
    send_stars(db, roster, bot)
  end
end
