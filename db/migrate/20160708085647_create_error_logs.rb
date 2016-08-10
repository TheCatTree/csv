class CreateErrorLogs < ActiveRecord::Migration
  def change
    create_table :error_logs do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.timestamps null: false
    end
  end
end
