class CreateContactsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :first_name

      t.timestamps
    end
  end
end
