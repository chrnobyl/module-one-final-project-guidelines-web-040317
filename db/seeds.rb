require 'csv'
require 'pry'

i = 0


CSV.foreach("./baseball-data/Teams.csv") do |row|
  unless i <= 0
    Team.create(
    name: row[40],
    league: row[1]
    )
  end
  i += 1
end

CSV.foreach("./baseball-data/Teams.csv") do |row|
  unless i <= 0
    Season.create(
    year: row[0],
    wins: row[8],
    losses: row[9],
    runs: row[14],
    home_runs: row[19],
    strike_outs: row[21],
    strike_outs_against: row[36],
    runs_against: row[26],
    home_runs_against: row[34]
    )
  end
  i += 1
end
