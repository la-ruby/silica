class AddTwoFieldsToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :analysis_url, :string, default: 'https://silica-bucket.s3.amazonaws.com/neutral/neutral/empty.pdf'
    add_column :projects, :analysis_at, :string
  end
end
