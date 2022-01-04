class CreateNavigations < ActiveRecord::Migration[6.1]
  def change
    create_table :navigations do |t|
      t.integer :user_id
      t.integer :place_id
      t.integer :starting_coordinate
      t.integer :ending_coordinate
      t.boolean :done
      t.time :time_deadline
      t.date :date

      t.timestamps
    end
  end
end
