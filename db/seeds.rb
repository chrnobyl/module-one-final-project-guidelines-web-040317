require 'csv'
require 'pry'

i = 0


CSV.foreach("./baseball-data/Teams.csv") do |row|
  unless i <= 0
    team = Team.find_or_create_by(
    name: row[40]
    )
    Season.create(
    team_id: team.id,
    year: row[0],
    league: row[1],
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
