require_relative '../config/environment'
ActiveRecord::Base.logger.level = 1

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

# def team_most_strikeouts_by_year(year)
#   team_strikeouts_by_year(:strike_outs, year).max_by{|team, so| so}
# end
#
# def team_most_wins_by_year(year)
#   team_wins_by_year(:wins, year).max_by{|team, wins| wins}
# end
#
# def team_most_hr_by_year(year)
#   stat_by_team_by_year(:home_runs, year).max_by{|team, hr| hr}
# end

def team_most_stat_year(statistic, year)
  stat_by_team_by_year(statistic, year).max_by{|team, statistic| statistic}
end

features = [
  ["The team that hit the most home runs in a given year", :home_runs],
  ["Team with the most wins in a given year", :wins, ],
  ["Team with the most strike outs in a given year", :strike_outs],
  ["Team with the most losses in a given year", :losses],
  ["Team with the most runs scored in a given year", :runs]
]

  # "Total Home Runs hit is a given year and average by team"


puts "Welcome to every baseball statistic ever. Please choose one of the following stats:"
features.each_with_index do |feature, index|
  puts "#{index + 1} - #{feature[0]}"
end

puts "Enter the number of the stat you want:"
feature = gets.chomp.to_i

puts "Please enter a year (YYYY):"
year = gets.chomp

most = team_most_stat_year(features[feature - 1][1], year)

stat_str = features[feature - 1][1].to_s.split('_').join(" ")
puts "The #{most[0]} had #{most[1]} #{stat_str}"


# case feature
# when 1
#     puts ask.red
#     year = gets.chomp
#     most_hr = team_most_hr_by_year(year)
#     puts "In #{year}, the #{most_hr[0]} hit an astounding #{most_hr[1]} home runs."
#     # binding.pry
#   when 2
#     puts ask.red
#     year = gets.chomp
#     most_wins = team_most_wins_by_year(year)
#     puts "In #{year}, the #{most_wins[0]} won #{most_wins[1]} games - the most wins of that year."
#   when 3
#     puts ask.red
#     year = gets.chomp
#     most_strikeouts = team_most_strikeouts_by_year(year)
#     puts "In #{year}, the #{most_strikeouts[0]} struck out #{most_strikeouts[1]} batters."
#   else
#     puts "Goodbye."
# end




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
