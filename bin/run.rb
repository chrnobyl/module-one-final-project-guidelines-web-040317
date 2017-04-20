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
