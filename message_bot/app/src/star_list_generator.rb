require './lib/atex_db'
require './lib/star_lister'

lister = StarLister.new
db = AtexDB.new
db.set_stars(lister.list_2434.flatten)
