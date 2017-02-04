class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.integer :love, default: 0
      t.timestamps
    end
  end
end
