class RemoveUserIdFromGiftCertificates < ActiveRecord::Migration
  def change
    remove_column :gift_certificates, :user_id, :integer
  end
end
