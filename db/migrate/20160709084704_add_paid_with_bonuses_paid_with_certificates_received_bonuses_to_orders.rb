class AddPaidWithBonusesPaidWithCertificatesReceivedBonusesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :paid_with_bonuses, :integer, :default => 0
    add_column :orders, :paid_with_certificates, :integer, :default => 0
    add_column :orders, :received_bonuses, :integer, :default => 0
  end
end
