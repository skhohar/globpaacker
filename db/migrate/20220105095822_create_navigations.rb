class CreateNavigations < ActiveRecord::Migration[6.1]
  def change
    create_table :navigations do |t|
      t.integer :user_id
      t.integer :starting_longitude
      t.integer :starting_latitude
      t.integer :ending_longitude
      t.integer :ending_latitude
      t.boolean :done
      t.date :date

      t.timestamps
    end
  end
end
