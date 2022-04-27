class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :record_id
      t.string :record_type
      t.integer :inventor_id

      t.timestamps
    end
  end
end
