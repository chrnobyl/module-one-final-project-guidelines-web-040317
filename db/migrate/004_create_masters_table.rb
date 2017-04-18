class CreateMastersTable < ActiveRecord::Migration
  def change
    create_table "Masters", id: false, force: :cascade do |t|
      t.text    "playerID"
      t.integer "birthYear"
      t.integer "birthMonth"
      t.integer "birthDay"
      t.text    "birthCountry"
      t.text    "birthState"
      t.text    "birthCity"
      t.integer "deathYear"
      t.integer "deathMonth"
      t.integer "deathDay"
      t.text    "deathCountry"
      t.text    "deathState"
      t.text    "deathCity"
      t.text    "nameFirst"
      t.text    "nameLast"
      t.text    "nameGiven"
      t.integer "weight"
      t.integer "height"
      t.text    "bats"
      t.text    "throws"
      t.text    "debut"
      t.text    "finalGame"
      t.text    "retroID"
      t.text    "bbrefID"
      t.index ["bbrefID"], name: "Master_bbrefID"
      t.index ["playerID"], name: "Master_playerID", unique: true
      t.index ["retroID"], name: "Master_retroID"
    end
  end
end
