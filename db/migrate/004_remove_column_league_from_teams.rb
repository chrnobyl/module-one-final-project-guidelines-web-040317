class RemoveColumnLeagueFromTeams < ActiveRecord::Migration
  def change
    remove_column(:teams, :league)
  end
end
