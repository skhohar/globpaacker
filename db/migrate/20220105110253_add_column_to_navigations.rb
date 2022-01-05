class AddColumnToNavigations < ActiveRecord::Migration[6.1]
  def change
    add_reference :navigations, :user, null: false, foreign_key: true
  end
end
