class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :pair, index: true
      t.integer :time

      t.timestamps null: false
    end
  end
end
