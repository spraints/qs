class UniqueUsername < ActiveRecord::Migration
  def change
    add_index :users, [:provider, :username], :unique => true
  end
end
