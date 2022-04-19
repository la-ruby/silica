class CreateProjectFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :project_files do |t|
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
