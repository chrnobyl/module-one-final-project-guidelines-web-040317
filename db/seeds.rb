require 'csv'
require 'pry'

i = 0

CSV.foreach("./baseball-data/Players.csv") do |row|
  unless i <= 0
    Player.create(nameFirst: row[1], nameLast: row[2])
  end
  i += 1
end
