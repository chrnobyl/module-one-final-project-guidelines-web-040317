class CreateSeasonsTable < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer   :year       #row 0
      t.integer   :wins       #row 8
      t.integer   :losses     #row 9
      t.integer   :runs       #row 14
      t.integer   :home_runs  #row 19
      t.integer   :strike_outs  #row 21
      t.integer   :strike_outs_against  #row 36
      t.integer   :runs_against   #row 26
      t.integer   :home_runs_against    #row 34
    end
  end
end
