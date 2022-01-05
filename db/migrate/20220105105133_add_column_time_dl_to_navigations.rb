class AddColumnTimeDlToNavigations < ActiveRecord::Migration[6.1]
  def change
    add_column :navigations, :time_deadline, :time
  end
end
