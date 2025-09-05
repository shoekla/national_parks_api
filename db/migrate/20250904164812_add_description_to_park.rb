class AddDescriptionToPark < ActiveRecord::Migration[8.0]
  def change
    add_column :parks, :description, :text
    remove_column :parks, :established_date, :date
  end
end
