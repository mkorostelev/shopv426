class AddIndexToGiftCertificatesToken < ActiveRecord::Migration
  def change
    add_index :gift_certificates, :token, unique: true
  end
end
