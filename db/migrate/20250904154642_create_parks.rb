class CreateParks < ActiveRecord::Migration[8.0]
  def change
    create_table :parks do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :states, array: true, default: []
      t.date :established_date
      t.jsonb :properties, default: {}, null: false
      t.string :national_parks_internal_id, null: false

      t.timestamps
    end

    add_index :parks, :code, unique: true
  end
end
