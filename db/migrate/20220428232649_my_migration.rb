class MyMigration < ActiveRecord::Migration[7.0]
  def up
    create_table :events do |t|
      t.string :category
      t.jsonb :data
      t.datetime :timestamp
      t.integer :record_id
      t.string :record_type
      t.integer :inventor_id
      t.integer :secondary_record_id
      t.string :secondary_record_type

      t.timestamps
    end

    create_table :comments do |t|
      t.integer :record_id
      t.string :record_type
      t.integer :inventor_id

      t.timestamps
    end

    add_column :repcs, :signed_by_company_at_whodunnit, :integer
  end
end
