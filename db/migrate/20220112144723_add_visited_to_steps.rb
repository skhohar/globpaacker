class AddVisitedToSteps < ActiveRecord::Migration[6.1]
  def change
    add_column :steps, :visited, :boolean
  end
end
