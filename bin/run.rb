require_relative '../config/environment'

# puts "Enter a team name: "
# name = gets.chomp
# puts "Enter a year: "
# year = gets.chomp


# User can select a year and return most home_runs


# Team with the most wins in a given year
# Team.joins(:seasons).where(seasons: {year: 1986})
# Season.where(team_id: 123, year: 1986)

def team_hr_by_year(year)
  team_hr = {}
  Team.joins(:seasons).where(seasons: {year: year}).each do |team|
    team_hr[team.name] = Season.where(team_id: team.id, year: year).first.home_runs
  end
  team_hr
end

def team_most_hr_by_year(year)
  team_hr_by_year(year).max_by{|team, hr| hr}
end

features = [
  "The team that hit the most home runs in a given year",
  "Team with the most wins in a given year",
  "Team with the most strike outs in a given year",
  "The most home runs a francise has hit in a given year",
  "Total Home Runs hit is a given year and average by team"
]


puts "Welcome to something"
features.each_with_index do |feature, index|
  puts "#{index + 1} - #{feature}"
end

puts "Please select a query (by number)"
feature = gets.chomp.to_i

if feature == 1
  puts "Please enter year (YYYY):"
  year = gets.chomp
  most_hr = team_most_hr_by_year(year)
  puts "In #{year} the #{most_hr[0]} hit an astounding #{most_hr[1]} home runs."
  # binding.pry
else
  puts "Goodbye!"
  exit
end




# def get_season(name, year)
#  team = Team.find_by(name: name)
#  team_season = team.seasons.find_by(year: year)
# end
#
# def league_array
#   Season.select(:league).distinct.collect do |season|
#     season.league
#   end
# end


# team_most_hr_by_year(1986)




# season = get_season(name, year)
# puts "Wins: #{season.wins}"


# Team.joins(:seasons).where(seasons: {year: (2000..2016)}).uniq
