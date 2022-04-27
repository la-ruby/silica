class AddFolderToProjectFiles < ActiveRecord::Migration[7.0]
  def change
    add_column :project_files, :folder, :string, default: 'root'
  end
end
