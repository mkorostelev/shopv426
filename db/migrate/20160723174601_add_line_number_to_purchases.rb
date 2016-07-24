class AddLineNumberToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :line_number, :integer, default: 0
  end
end
