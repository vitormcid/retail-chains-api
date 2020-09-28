class CreateIncidences < ActiveRecord::Migration[5.2]
  def change
    create_table :incidences do |t|
      t.integer  :visitor_id
      t.string   :kind
      t.datetime :datetime

      t.timestamps
    end
  end
end
