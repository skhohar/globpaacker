class AddWeatherToNavigations < ActiveRecord::Migration[6.1]
  def change
    add_column :navigations, :weather, :string
  end
end
