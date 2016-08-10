class CreateUserFiles < ActiveRecord::Migration
  def change
    create_table :user_files do |t|
      t.belongs_to :user, index: true
      t.string :file
      t.timestamps null: false
    end
  end
end
