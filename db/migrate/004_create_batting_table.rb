class CreateBattingsTable < ActiveRecord::Migration
  def change
    create_table :battings do |t|
      t.text    "playerID"
      t.integer "yearID"
      t.integer "stint"
      t.text    "teamID"
      t.text    "lgID"
      t.integer "G"
      t.integer "G_batting"
      t.integer "AB"
      t.integer "R"
      t.integer "H"
      t.integer "2B"
      t.integer "3B"
      t.integer "HR"
      t.integer "RBI"
      t.integer "SB"
      t.integer "CS"
      t.integer "BB"
      t.integer "SO"
      t.integer "IBB"
      t.integer "HBP"
      t.integer "SH"
      t.integer "SF"
      t.integer "GIDP"
    end
  end
end
