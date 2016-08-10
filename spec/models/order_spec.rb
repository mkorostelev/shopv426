require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to :user }

  it { should have_many :gift_certificates }

  it { should have_many :purchases }

  it { should validate_presence_of :purchases }

  let(:order) { Order.new }

  it do
    should validate_numericality_of(:amount).
        is_greater_than_or_equal_to(0)
  end

  it do
    should validate_numericality_of(:paid_with_bonuses).
        is_greater_than_or_equal_to(0)
  end

  it do
    should validate_numericality_of(:paid_with_certificates).
        is_greater_than_or_equal_to(0)
  end

  it do
    should validate_numericality_of(:received_bonuses).
        is_greater_than_or_equal_to(0)
  end
end
