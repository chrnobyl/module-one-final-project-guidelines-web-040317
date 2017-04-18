class CreateBattingsTable < ActiveRecord::Migration
  def change
    create_table "Battings", id: false, force: :cascade do |t|
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
      t.integer "G_old"
      t.index ["lgID"], name: "Batting_lgID"
      t.index ["playerID", "yearID", "stint"], name: "Batting_Index_7170BE9D_268A_46B8", unique: true
      t.index ["teamID"], name: "Batting_teamID"
    end
  end
end
