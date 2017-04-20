require_relative '../config/environment'
ActiveRecord::Base.logger.level = 1


def features
  {
  max_by_year: [
  ["The team with the most home runs in a given year", "home_runs"],
  ["Team with the most wins in a given year", "wins"],
  ["Team with the most strike outs in a given year", "strike_outs"],
  ["Team with the most losses in a given year", "losses"],
  ["Team with the most runs scored in a given year", "runs"]
  ],
  avg_by_year: [
    ["The average home runs per team in a given year", "home_runs"],
    ["Team average wins per team in a given year", "wins"],
    ["Team average strike outs per team in a given year", "strike_outs"],
    ["Team average losses per team in a given year", "losses"],
    ["Team average runs scored per team in a given year", "runs"]
  ]
  }
end


def max_team_stat_year(statistic, year)
  max_stat = Season.where(year: year).maximum(statistic)
  max_team = Team.joins(:seasons).where(seasons: {year: year, statistic => max_stat})
  {statistic => max_stat, team: max_team.first.name}
end

def avg_stat_year(statistic, year)
  Season.where(year: year).average(statistic)
end

def max_by_year
  puts "Available max stats by year:"
  features[:max_by_year].each_with_index {|feature, index| puts "#{index + 1} - #{feature[0]}"}

  puts "Please enter the stat you want (by number):"
  num = gets.chomp.to_i
  puts "Please enter a year (YYYY):"
  year = gets.chomp

  statistic = features[:max_by_year][num - 1][1]
  max = max_team_stat_year(statistic, year)
  puts "The #{max[:team]} had #{max[statistic]} #{statistic.split('_').join(' ')}"
end

def avg_by_year
  puts "Available avg stats by year:"
  features[:avg_by_year].each_with_index {|feature, index| puts "#{index + 1} - #{feature[0]}"}

  puts "Please enter the stat you want (by number):"
  num = gets.chomp.to_i
  puts "Please enter a year (YYYY):"
  year = gets.chomp

  statistic = features[:avg_by_year][num - 1][1]
  avg = avg_stat_year(statistic, year)
  puts "The average team in #{year} had #{avg} #{statistic}"
end



puts "Welcome to every baseball statistic ever. Please choose a category of stats:"
features.keys.each_with_index {|key, index| puts "#{index + 1} - #{key.to_s.split('_').join(' ')}"}

puts "Enter the number of the category you want:"
feature = gets.chomp.to_i

send(features.keys[feature -1])
