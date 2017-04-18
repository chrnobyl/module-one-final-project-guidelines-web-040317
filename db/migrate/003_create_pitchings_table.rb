class CreatePitchingsTable < ActiveRecord::Migration
  def change
    create_table "Pitchings", id: false, force: :cascade do |t|
      t.text    "playerID"
      t.integer "yearID"
      t.integer "stint"
      t.text    "teamID"
      t.text    "lgID"
      t.integer "W"
      t.integer "L"
      t.integer "G"
      t.integer "GS"
      t.integer "CG"
      t.integer "SHO"
      t.integer "SV"
      t.integer "IPouts"
      t.integer "H"
      t.integer "ER"
      t.integer "HR"
      t.integer "BB"
      t.integer "SO"
      t.integer        "BAOpp"
      t.integer        "ERA"
      t.integer "IBB"
      t.integer "WP"
      t.integer "HBP"
      t.integer "BK"
      t.integer "BFP"
      t.integer "GF"
      t.integer "R"
      t.integer "SH"
      t.integer "SF"
      t.integer "GIDP"
      t.index ["lgID"], name: "Pitching_lgID"
      t.index ["playerID", "yearID", "stint"], name: "Pitching_Index_481778A5_18F2_430E", unique: true
      t.index ["teamID"], name: "Pitching_teamID"
    end
  end
end
