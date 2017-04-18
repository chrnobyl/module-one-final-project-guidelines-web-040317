require 'csv'
require 'pry'

i = 0

CSV.foreach("./baseball-data/Players.csv") do |row|
  unless i <= 0
    Player.create(playerID: row[0], nameFirst: row[1], nameLast: row[2], bats: row[3], throws: row[4], debut: row[5], finalGame: row[6])
  end
  i += 1
end

# CSV.foreach("./baseball-data/.csv") do |row|
#   unless i <= 0
#     Player.create(playerID: row[0], nameFirst: row[1], nameLast: row[2], bats: row[3], throws: row[4], debut: row[5], finalGame: row[6])
#   end
#   i += 1
# end

CSV.foreach("./baseball-data/Teams.csv") do |row|
  unless i <= 0
    Team.create(yearID: row[0], lgID: row[1], teamID: row[2], franchID: row[3], divID: row[4], Rank: row[5], G: row[6], Ghome: row[7], W: row[8], L: row[9], DivWin: row[10], WCWin: row[11], LgWin: row[12], WSWin: row[13], R: row[14], AB: row[15], H: row[16], 2B: row[17], 3B: row[18], HR: row[19], BB: row[20], SO: row[21], SB: row[22], CS: row[23], HBP: row[24], SF: row[25], RA: row[26], ER: row[27], ERA: row[28], CG: row[29], SHO: row[30], SV: row[31], IPouts: row[32], HA: row[33], HRA: row[34], BBA: row[35], SOA: row[36], E: row[37], DP: row[38], FP: row[39], name: row[40], park: row[41], attendance: row[42], BPF: row[43], PPF: row[44], teamIDBR: row[45], teamIDlahman45: row[46], teamIDretro: row[47])
  end
  i += 1
end

CSV.foreach("./baseball-data/Pitching.csv") do |row|
  unless i <= 0
    Team.create(playerID: row[0], yearID: row[1], stint: row[2], teamID: row[3], lgID: row[4], W: row[5], L: row[6], G: row[7], GS: row[8], CG: row[9], SHO: row[10], SV: row[11], IPouts: row[12], H: row[13], ER: row[14], HR: row[15], BB: row[16], SO: row[17], BAOpp: row[18], ERA: row[19], IBB: row[20], WP: row[21], HBP: row[22], BK: row[23], BFP: row[24], GF: row[25], R: row[26], SH: row[27], SF: row[28], GIDP: row[29])
  end
  i += 1
end

CSV.foreach("./baseball-data/Batting.csv") do |row|
  unless i <= 0
    Team.create(yearID: row[1], stint: row[2], teamID: row[3], lgID: row[4], G: row[5], AB: row[6], R: row[7], H: row[8], 2B: row[9], 3B: row[10], HR: row[11], RBI: row[12], SB: row[13], CS: row[14], BB: row[15], SO: row[16], IBB: row[17], HBP: row[18], SH: row[19], SF: row[20], GIDP: row[21])
  end
  i += 1
end
