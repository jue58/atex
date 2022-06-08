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

  #
  # stars: [key1, value1, key2, value2, ...]
  #
  def set_stars(stars)
    @r.hmset(:stars, stars)
  end
  
  def match_stars(name_list)
    @r.hmget(:stars, name_list)
  end
end
