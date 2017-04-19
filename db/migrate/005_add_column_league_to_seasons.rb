class AddColumnLeagueToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :league, :string
  end
end
