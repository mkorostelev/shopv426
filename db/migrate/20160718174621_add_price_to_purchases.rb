class AddPriceToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :price, :integer, :default => 0
    add_column :purchases, :amount, :integer, :default => 0
    add_column :purchases, :discount_percent, :integer, :default => 0
    add_column :purchases, :discount_amount, :integer, :default => 0
    add_column :purchases, :amount_to_pay, :integer, :default => 0

    add_column :orders, :discount_percent, :integer, :default => 0
    add_column :orders, :discount_amount, :integer, :default => 0
    add_column :orders, :amount_to_pay, :integer, :default => 0
  end
end
