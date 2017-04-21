require_relative '../config/environment'
require_relative '../linear-regression.rb'

ActiveRecord::Base.logger.level = 1
require_all 'lib'

YEAR_RANGE = (1871..2016)
def features
  {
  max_by_year: [
  ["Team with the most wins in a given year", "wins"],
  ["Team with the most losses in a given year", "losses"],
  ["The team with the most home runs in a given year", "home_runs"],
  ["The team with the most home runs against in a given year", "home_runs_against"],
  ["Team with the most strike outs in a given year", "strike_outs"],
  ["Team with the most strike outs against in a given year", "strike_outs_against"],
  ["Team with the most runs scored in a given year", "runs"],
  ["Team with the most runs against in a given year","runs_against"]
  ],
  avg_by_year: [
    ["The average home runs per team in a given year", "home_runs"],
    ["The average home runs against per team in a given year", "home_runs_against"],
    ["The average strike outs per team in a given year", "strike_outs"],
    ["The average strike out against per team in a given year", "strike_outs_against"],
    ["The average runs scored per team in a given year", "runs"],
    ["The average runs against per team in a given year", "runs_against"]
  ],
  compare_a_team_to_avg: [
    ["wins", "wins"],
    ["losses", "losses"],
    ["home runs", "home_runs"],
    ["home runs against", "home_runs_against"],
    ["strike outs", "strike_outs"],
    ["strike outs against", "strike_outs_against"],
    ["runs", "runs"],
    ["runs against","runs_against"]
  ],
  simple_linear_regression: [
    ["wins", "wins"],
    ["losses", "losses"],
    ["home runs", "home_runs"],
    ["home runs against", "home_runs_against"],
    ["strike outs", "strike_outs"],
    ["strike outs against", "strike_outs_against"],
    ["runs", "runs"],
    ["runs against","runs_against"]
  ]
  }
end

def linear_regression(start_year, end_year, y_stat, x_stat)
  data_series = {ys: [], xs: []}
  Season.where(year: start_year..end_year).each do |season|
    data_series[:ys] << season[y_stat]
    data_series[:xs] << season[x_stat]
  end
  balanced_data_series = balance(data_series)

  regression = LinearRegression.new(balanced_data_series[:xs], balanced_data_series[:ys])
  [balanced_data_series[:xs].length, regression.slope]
end

def balance(data_series)
  if data_series[:ys].length > data_series[:xs].length
    data_series[:ys].pop(data_series[:ys].length - data_series[:xs].length)
  elsif data_series[:xs].length > data_series[:ys].length
    data_series[:xs].pop(xs.length - data_series[:ys].length)
  end
  data_series
end

def max_team_stat_year(statistic, year)
  max_stat = Season.where(year: year).maximum(statistic)
  max_team = Team.joins(:seasons).where(seasons: {year: year, statistic => max_stat})
  {statistic => max_stat, team: max_team.first.name}
end

def avg_stat_year(statistic, year)
  Season.where(year: year).average(statistic).round(2)
end

def teams_by_year(year)
  Team.joins(:seasons).where(seasons: {year: year})
end

def simple_linear_regression
  puts "Enter the starting year (YYYY):".green
  start_year = gets.chomp
  if start_year == "exit"
    return "exit"
  end
  until YEAR_RANGE.include?(start_year.to_i) == true
    puts "There are no stats for that year. Please enter a year from the 1871 - 2016:".green
    start_year = gets.chomp
  break if start_year == "exit"
  end
  if start_year == "exit"
    return "exit"
  end
  start_year.to_i

  puts "Enter the ending year (YYYY):".green
  end_year = gets.chomp
  if end_year == "exit"
    return "exit"
  end
  until YEAR_RANGE.include?(end_year.to_i) == true
    puts "There are no stats for that year. Please enter a year from the 1871 - 2016:".green
    end_year = gets.chomp
  break if end_year == "exit"
  end
  if end_year == "exit"
    return "exit"
  end
  end_year.to_i

  puts "Available statistics to test:".green

  linstats_indices = []
  features[:simple_linear_regression].each_with_index do |feature, index|
    puts "#{index + 1} - #{feature[0]}"
    linstats_indices << (index + 1).to_s
  end

  puts "Choose the independent statistic (by number):".green
  y_num = gets.chomp
  if y_num == "exit"
    return "exit"
  end
  until linstats_indices.include?(y_num) == true
    puts "That stat is not listed. Please enter a number from the list of statistics:".green
    y_num = gets.chomp
  break if y_num == "exit"
  end
  if y_num == "exit"
    return "exit"
  end
  y_num = y_num.to_i

  y_stat = features[:simple_linear_regression][y_num - 1][1]
  y_stat_name = features[:simple_linear_regression][y_num - 1][0]

  puts "Choose the dependent statistic (by number):".green
  x_num = gets.chomp
  if x_num == "exit"
    return "exit"
  end
  until linstats_indices.include?(x_num) == true
    puts "That stat is not listed. Please enter a number from the list of statistics:".green
    x_num = gets.chomp
  break if x_num == "exit"
  end
  if x_num == "exit"
    return "exit"
  end
  x_num = x_num.to_i

  x_stat = features[:simple_linear_regression][x_num - 1][1]
  x_stat_name = features[:simple_linear_regression][x_num - 1][0]

  regression = linear_regression(start_year, end_year, y_stat, x_stat)

  puts "
A set of " + "#{regression[0]}".bold.blue + " data pairs were analyzed for the period of " + "#{start_year}".bold.blue + " to " + "#{end_year}".bold.blue + ".
  "
  puts "During this period, " + "#{y_stat_name}".bold.blue + " and " + "#{x_stat_name}".bold.blue + " have a correlation of " + "#{regression[1].round(2)}".bold.blue + ".
  "
end

def compare_a_team_to_avg
  puts "Please enter a year from 1871 - 2016 (YYYY):".green
  year = gets.chomp
  if year == "exit"
    return "exit"
  end
  until YEAR_RANGE.include?(year.to_i) == true
    puts "There are no stats for that year. Please enter a year from the 1871 - 2016:".green
    year = gets.chomp
  break if year == "exit"
  end
  if year == "exit"
    return "exit"
  end

  comp_indices = []
  teams = teams_by_year(year)
  teams.each_with_index do |team, index|
    puts "#{index + 1} - #{team.name}"
    comp_indices << (index + 1).to_s
  end

  puts "Please select a team (by number):".green
  num = gets.chomp
  if num == "exit"
    return "exit"
  end
  until comp_indices.include?(num) == true
    puts "That team is not listed. Please enter a number from the list of teams:".green
    num = gets.chomp
  break if num == "exit"
  end
  if num == "exit"
    return "exit"
  end
  num = num.to_i
  team = teams[num - 1]

  puts "
In #{year} the #{team.name} had:
  ".bold.blue
  features[:compare_a_team_to_avg].each do |feature|
    avg_stat = avg_stat_year(feature[1], year)
    team_stat = Season.where(team_id: team.id, year: year).first[feature[1]]
    puts "#{team_stat}".bold.blue + " #{feature[0]}".bold.blue + " vs. an average of " + "#{avg_stat}".bold.blue + ".
    "
  end
end


def max_by_year
  mby_indices = []
  puts "Available max stats by year:".green
  features[:max_by_year].each_with_index do |feature, index|
   puts "#{index + 1} - #{feature[0]}"
   mby_indices << (index + 1).to_s
  end

  puts "Please enter the stat you want (by number):".green
  num = gets.chomp
  until mby_indices.include?(num) == true
    puts "That stat does not exist. Please enter a number from the list of statistics:".green
    num = gets.chomp
  break if num == "exit"
  end
  if num == "exit"
    return "exit"
  end
  num = num.to_i

  puts "Please enter a year from 1871 - 2016 (YYYY):".green
  year = gets.chomp
  if year == "exit"
    return "exit"
  end
  until YEAR_RANGE.include?(year.to_i) == true
    puts "There are no stats for that year. Please enter a year from the 1871 - 2016:".green
    year = gets.chomp
  break if year == "exit"
  end
  if year == "exit"
    return "exit"
  end

  statistic = features[:max_by_year][num - 1][1]
  max = max_team_stat_year(statistic, year)
  puts "
The " +"#{max[:team]}".bold.blue + " had " + "#{max[statistic]} #{statistic.split('_').join(' ')}".bold.blue + ".
  "
end

def avg_by_year
  aby_indices = []
  puts "Available avg stats by year:".green
  features[:avg_by_year].each_with_index do |feature, index|
    puts "#{index + 1} - #{feature[0]}"
    aby_indices << (index + 1).to_s
  end

 puts "Please enter the stat you want (by number):".green
 num = gets.chomp
 if num == "exit"
   return "exit"
 end
 until aby_indices.include?(num) == true
   puts "That stat does not exist. Please enter a number from the category list:".green
   num = gets.chomp
 break if num == "exit"
 end
 if num == "exit"
   return "exit"
 end
 num = num.to_i

 puts "Please enter a year from 1871 - 2016 (YYYY):".green
 year = gets.chomp
 if year == "exit"
   return "exit"
 end
 until YEAR_RANGE.include?(year.to_i) == true
   puts "There are no stats for that year. Please enter a year from the 1871 - 2016:".green
   year = gets.chomp
 break if year == "exit"
 end
 if year == "exit"
   return "exit"
 end

 statistic = features[:avg_by_year][num - 1][1]
 avg = avg_stat_year(statistic, year)
 puts "
The average team in " + "#{year}".bold.blue + " had " + "#{avg} #{statistic.split("_").join(" ")}".bold.blue + ".
 "

end



puts "        _                    _           _ _
       | |                  | |         | | |
       | |__   __ _ ___  ___| |__   __ _| | |
       | '_ \\ / _` / __|/ _ \\ '_ \\ / _` | | |
       | |_) | (_| \\__ \\  __/ |_) | (_| | | |
       |_.__/ \\__,_|___/\\___|_.__/ \\__,_|_|_|
                                             ".bold.red


var = ""
while var != "exit"


  puts "Welcome to every baseball statistic ever. Type 'exit' at any time to quit the program. Please choose a category of stats:".bold.red
  menu_indices = []
  features.keys.each_with_index do |key, index|
    puts "#{index + 1} - #{key.to_s.split('_').join(' ')}"
    menu_indices << (index + 1).to_s
  end

  puts "Enter the number of the category you want:".green
  feature = gets.chomp
  if feature == "exit"
    break
  end
  until menu_indices.include?(feature) == true
    puts "That category does not exist. Please enter a number from the category list:".green
    feature = gets.chomp
    break if feature == "exit"
  end
  if feature == "exit"
    break
  end

  feature = feature.to_i
  var = send(features.keys[feature -1])

end

exit_messages = ["Ok bye.", "Goodbye!", "Have a wonderful day.", "Y'all come back now, ya hear?", "You're out."]
puts "
#{exit_messages.sample}
".bold.red
