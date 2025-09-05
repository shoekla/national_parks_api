class AddInternalIdToParks < ActiveRecord::Migration[8.0]
  def change
    add_column :parks, :national_parks_internal_id, :string
    add_column :alerts, :national_parks_internal_id, :string
  end
end
