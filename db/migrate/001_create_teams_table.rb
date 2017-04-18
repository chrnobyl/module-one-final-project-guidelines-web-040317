class CreateTeamsTable < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string  :name        #row 40
      t.string  :league      #row 1
    end
  end
end
