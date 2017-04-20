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

puts "        _                    _           _ _
       | |                  | |         | | |
       | |__   __ _ ___  ___| |__   __ _| | |
       | '_ \\ / _` / __|/ _ \\ '_ \\ / _` | | |
       | |_) | (_| \\__ \\  __/ |_) | (_| | | |
       |_.__/ \\__,_|___/\\___|_.__/ \\__,_|_|_|
                                             ".bold.red




  def max_by_year
   puts "Available max stats by year:".green
   features[:max_by_year].each_with_index {|feature, index| puts "#{index + 1} - #{feature[0]}"}

   puts "Please enter the stat you want (by number):".green
   num = gets.chomp
   if num == "exit"
     return "exit"
   end
   num = num.to_i

   puts "Please enter a year (YYYY):".green
   year = gets.chomp
   if year == "exit"
     return "exit"
   end

   statistic = features[:max_by_year][num - 1][1]
   max = max_team_stat_year(statistic, year)
   puts "The #{max[:team]} had #{max[statistic]} #{statistic.split('_').join(' ')}"
  end

  def avg_by_year
   puts "Available avg stats by year:".green
   features[:avg_by_year].each_with_index {|feature, index| puts "#{index + 1} - #{feature[0]}"}

   puts "Please enter the stat you want (by number):".green
   num = gets.chomp
   if num == "exit"
     return "exit"
   end
   num = num.to_i

   puts "Please enter a year (YYYY):".green
   year = gets.chomp
   if year == "exit"
     return "exit"
   end

   statistic = features[:avg_by_year][num - 1][1]
   avg = avg_stat_year(statistic, year)
   puts "The average team in " + "#{year}".bold.green + " had " + "#{avg} #{statistic}".bold.green + "."
  end

var = ""
while var != "exit"

  puts "Welcome to every baseball statistic ever. Type 'exit' at any time to quit the program. Please choose a category of stats:".bold.red
  features.keys.each_with_index {|key, index| puts "#{index + 1} - #{key.to_s.split('_').join(' ')}"}


  puts "Enter the number of the category you want:".green
  feature = gets.chomp
    if feature == "exit"
      break
    end
  feature = feature.to_i

  var = send(features.keys[feature -1])




  # puts "Please enter a year from 1871 - 2016 (YYYY):"
  # year = gets.chomp
  # if year == "exit"
  #   break
  # end
  # year = year.to_i
  #
  # if year.to_s.length != 4
  #   puts "Please enter a year in YYYY format:"
  #   year = gets.chomp
  #   if year == "exit"
  #     break
  #   end
  #   year = year.to_i
  #
  # elsif year.to_i < 1871 || year.to_i > 2016
  #   puts "No records exist for that year. Please enter a valid year:"
  #   year = gets.chomp
  #   if year == "exit"
  #     break
  #   end
  #   year = year.to_i
  # else
  #   most = team_most_stat_year(features[feature - 1][1], year)
  #   stat_str = features[feature - 1][1].to_s.split('_').join(" ")
  #   puts "The " + "#{most[0]}".green + " had " + "#{most[1]}".green + " #{stat_str}.".green
  #   break
  # end
end

puts "WHATEVER BYE.".bold.red
