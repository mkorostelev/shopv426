class CreateGiftCertificates < ActiveRecord::Migration
  def change
    create_table :gift_certificates do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :order, index: true, foreign_key: true
      t.integer :amount, :default => 0
      t.string :token

      t.timestamps null: false
    end
  end
end
