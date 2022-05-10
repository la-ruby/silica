class AddMarketingMailSentToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :marketing_mail_sent, :string
  end
end
