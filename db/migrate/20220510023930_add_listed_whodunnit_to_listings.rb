class AddListedWhodunnitToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :listed_whodunnit, :integer
  end
end
