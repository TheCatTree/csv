class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.belongs_to :event, index: true
      t.integer :no
      t.string :name
      t.string :vtype
      t.string :value

      t.timestamps null: false
    end
  end
end
