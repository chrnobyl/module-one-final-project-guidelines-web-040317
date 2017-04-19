require_relative '../config/environment'

puts "Enter a team name: "
name = gets.chomp
puts "Enter a year: "
year = gets.chomp

def get_season(name, year)
  binding.pry
 team = Team.find_by(name: name)
 team_season = team.seasons.find_by(year: year)
 puts team_season
end

get_season(name, year)
