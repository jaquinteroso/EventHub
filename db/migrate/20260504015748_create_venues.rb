class CreateVenues < ActiveRecord::Migration[8.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.integer :capacity_max

      t.timestamps
    end
  end
end
