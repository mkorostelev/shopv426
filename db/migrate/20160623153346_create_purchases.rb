class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :product, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
