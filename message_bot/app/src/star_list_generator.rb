require 'csv'
require './lib/atex_db'
require './lib/star_lister'

custom_list_file_name = ARGV[0]

lister = StarLister.new
db = AtexDB.new

n_list = lister.list_2434.flatten
db.set_stars(n_list) unless n_list.empty?

if File.exist?(custom_list_file_name)
  custom_list = CSV.read(custom_list_file_name).flatten
  db.set_stars(custom_list) unless custom_list.empty?
end
