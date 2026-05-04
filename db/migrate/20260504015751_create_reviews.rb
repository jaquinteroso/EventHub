class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
