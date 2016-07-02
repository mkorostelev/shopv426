class AddBalanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :balance, :integer, :default => 0
    add_column :users, :bonus_points, :integer, :default => 0
  end
end
