class AddOrderToPurchase < ActiveRecord::Migration
  def change
    add_reference :purchases, :order, index: true, foreign_key: true
  end
end
