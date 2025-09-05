class CreateAlerts < ActiveRecord::Migration[8.0]
  def change
    create_table :alerts do |t|
      t.references :park, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :category
      t.date :last_indexed_date

      t.timestamps
    end
  end
end
