require_relative '../config/environment'

puts "Enter a team name: "
name = gets.chomp
puts "Enter a year: "
year = gets.chomp

def get_season(name, year)
 team = Team.find_by(name: name)
 team_season = team.seasons.find_by(year: year)
end

def league_array
  binding.pry
  Season.select(:league).distinct.collect do |season|
    season.league
  end
end

# puts league_array

season = get_season(name, year)
puts "Wins: #{season.wins}"
