class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.belongs_to :error_log, index: true
      t.integer :level
      t.string :symbol
      t.integer :vamount
      t.timestamps null: false
    end
  end
end
