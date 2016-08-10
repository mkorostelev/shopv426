require 'rails_helper'

RSpec.describe GiftCertificate, type: :model do
  it { should belong_to :order }

  it { should_not validate_presence_of :token }

  let(:gift_certificate) { build(:gift_certificate) }

  it 'fill token before validation' do
    gift_certificate.valid?

    expect(gift_certificate.token).not_to eq(nil)
  end

  it 'is invalid with a duplicate token' do
    create(:gift_certificate,
      token: 'qwerty')

    gift_certificate.token = 'qwerty'

    gift_certificate.valid?

    expect(gift_certificate.errors[:token]).to include("has already been taken")
  end
end
