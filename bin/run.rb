require_relative '../config/environment'
require_all 'lib'

def stat_by_team_by_year(statistic, year)
  return nil if !check_stat(statistic)
  team_stat = {}
  Team.joins(:seasons).where(seasons: {year: year}).each do |team|
    team_stat[team.name] = Season.where(team_id: team.id, year: year).first[statistic]
  end
  team_stat
end

def check_stat(statistic)
  Season.column_names().collect {|column| column.to_sym}.include?(statistic)
end


def team_most_hr_by_year(year)
  stat_by_team_by_year(:home_runs, year).max_by{|team, hr| hr}
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
