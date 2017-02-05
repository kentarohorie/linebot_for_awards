class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_battle, :integer, default: 0
  end
end
