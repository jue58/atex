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

def create_roster_text(roster)
  teams = roster.group_by{|v| v['team_id']}
  name_list = teams.map do |_, t|
    t.map {|p| format_name(p)}
  end
  return '' if name_list.empty?

  roster_str = name_list.map{|v| "- #{v.join(",  ")}\n"}.join
  <<~EOS
    ----------------------------------------------------
    今回の参加者

    #{roster_str}
  EOS
end

def create_stars_text(db, roster)
  name_list = roster.map{|v| v['name']}
  matched_stars = db.match_stars(name_list)

  p "matched_stars: #{matched_stars}"    

  star_result = name_list.zip(matched_stars).to_h.compact
  return '' if star_result.empty?

  result_str = star_result.map{|k, v| "#{k} => #{v}\n"}.join
  <<~EOS
    ----------------------------------------------------
    もしかしたらこの人とマッチしてるかも...？

    #{result_str}
  EOS
end

#################################################
# kokokara                                      #
#################################################
db = AtexDB.new

get_roster(db) do |roster|
  bot = DiscordBot.new(token: ENV['DISCORD_TOKEN'], channel: ENV['DISCORD_CHANNEL'])
  
  p "roster: #{roster}"

  unless roster.empty?
    roster.each do |v|
      num = db.increment_encounter(v['name'])
      v['encounter'] = num if num > 1
    end

    roster_text = create_roster_text(roster)
    bot.send_message(roster_text) unless roster_text.empty?
    stars_text = create_stars_text(db, roster)
    bot.send_message(stars_text) unless stars_text.empty?
  end
end
