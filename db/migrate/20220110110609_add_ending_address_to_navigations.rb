class AddEndingAddressToNavigations < ActiveRecord::Migration[6.1]
  def change
    add_column :navigations, :ending_address, :string
  end
end
