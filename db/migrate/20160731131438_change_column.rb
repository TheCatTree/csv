class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :events, :time, :integer, :limit => 8
  end
end
