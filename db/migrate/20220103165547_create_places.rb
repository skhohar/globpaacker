class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.string :photo
      t.string :description
      t.string :interest
      t.boolean :exterior
      t.integer :duration
      t.string :senses
      t.string :environment
      t.integer :rating

      t.timestamps
    end
  end
end
