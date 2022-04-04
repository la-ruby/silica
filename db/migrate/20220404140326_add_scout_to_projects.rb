class AddScoutToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :scout, :text
  end
end
