class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.integer :max_capacity
      t.integer :state
      t.integer :user_id
      t.integer :category_id
      t.integer :venue_id

      t.timestamps
    end
  end
end
