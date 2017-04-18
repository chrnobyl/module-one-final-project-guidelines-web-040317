class CreatePlayersTable < ActiveRecord::Migration
  def change
    create_table "Players" do |t|
      t.text    "playerID"
      t.text    "nameFirst"
      t.text    "nameLast"
      t.text    "bats"
      t.text    "throws"
      t.text    "debut"
      t.text    "finalGame"
    end
  end
end
