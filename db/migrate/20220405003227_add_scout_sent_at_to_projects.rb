class AddScoutSentAtToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :scout_sent_at, :string
  end
end
