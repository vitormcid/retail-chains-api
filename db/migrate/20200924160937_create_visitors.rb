class CreateVisitors < ActiveRecord::Migration[5.2]
  def change
    create_table :visitors do |t|
      t.string :name
      t.integer :chain_id

      t.timestamps
    end
  end
end
