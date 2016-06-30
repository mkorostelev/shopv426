class ChangeOrdersAmountDefault < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.change :amount, :integer, :default => 0
    end
  end
end
