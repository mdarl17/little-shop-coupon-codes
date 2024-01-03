class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items, id: false do |t|
      t.integer :id
      t.string :name
      t.string :description
      t.integer :unit_price
      t.integer :merchant_id
      t.datetime :created_at
      t.datetime :updated_at

    end
  end
end
