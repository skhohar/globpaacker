class ChangeColumnLongitudeLatitudeToNavigations < ActiveRecord::Migration[6.1]
  def change
    change_column :navigations, :starting_longitude, :float
    change_column :navigations, :starting_latitude, :float
    change_column :navigations, :ending_longitude, :float
    change_column :navigations, :ending_latitude, :float
  end
end
