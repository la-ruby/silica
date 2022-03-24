class CreateContactsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_mobile
      t.string :phone_work
      t.string :email
      t.string :investing_location
      t.string :sendgrid_created_at
      t.string :sendgrid_created_at_searchable

      t.timestamps
    end
  end
end
