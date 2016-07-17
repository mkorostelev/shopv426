class AddPaidWithRealMoneyToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :paid_with_real_money, :integer, :default => 0
  end
end
