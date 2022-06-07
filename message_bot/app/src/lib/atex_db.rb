require 'redis'

class AtexDB
  def initialize
    @r = Redis.new(host: :redis)
  end

  def get_roster
    @r.lrange(:roster, 0, -1)
  end

  def del_roster
    @r.del(:roster)
  end

  def match_stars(name_list)
    @r.hmget(:stars, name_list)
  end
end