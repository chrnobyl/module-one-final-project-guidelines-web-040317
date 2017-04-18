class AddTeamIdToSeasonsTable < ActiveRecord::Migration
  def change
    add_column :seasons, :team_id, :integer
  end
end
