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

def team_wins_by_year(year)
  team_wins = {}
  Team.joins(:seasons).where(seasons: {year: year}).each do |team|
    team_wins[team.name] = Season.where(team_id: team.id, year: year).first.wins
  end
  team_wins
end

def team_strikeouts_by_year(year)
  team_strikeouts = {}
  Team.joins(:seasons).where(seasons: {year: year}).each do |team|
    team_strikeouts[team.name] = Season.where(team_id: team.id, year: year).first.strike_outs
  end
  team_strikeouts
end

def team_most_strikeouts_by_year(year)
  team_strikeouts_by_year(year).max_by{|team, so| so}
end

def team_most_wins_by_year(year)
  team_wins_by_year(year).max_by{|team, wins| wins}
end

def team_most_hr_by_year(year)
  team_hr_by_year(year).max_by{|team, hr| hr}
end

features = [
  "The team that hit the most home runs in a given year",
  "Team with the most wins in a given year",
  "Team with the most strike outs in a given year",
  "The most home runs a francise has hit in a given year",
  "Total home runs hit in a given year and average by team"
]


puts "Welcome to every baseball statistic ever. Please choose one of the following stats:"
features.each_with_index do |feature, index|
  puts "#{index + 1} - #{feature}"
end

puts "Enter the number of the stat you want:"
feature = gets.chomp.to_i

ask = "Please enter a year (YYYY):"
case feature
when 1
    puts ask
    year = gets.chomp
    most_hr = team_most_hr_by_year(year)
    puts "In #{year}, the #{most_hr[0]} hit an astounding #{most_hr[1]} home runs."
    # binding.pry
  when 2
    puts ask
    year = gets.chomp
    most_wins = team_most_wins_by_year(year)
    puts "In #{year}, the #{most_wins[0]} won #{most_wins[1]} games - the most wins of that year."
  when 3
    puts ask
    year = gets.chomp
    most_strikeouts = team_most_strikeouts_by_year(year)
    puts "In #{year}, the #{most_strikeouts[0]} struck out #{most_strikeouts[1]} batters."
  else
    puts "Goodbye."
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
