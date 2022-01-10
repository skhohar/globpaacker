class AddStartingAddressToNavigations < ActiveRecord::Migration[6.1]
  def change
    add_column :navigations, :starting_address, :string
  end
end
