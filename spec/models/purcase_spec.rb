require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it { should belong_to :product }

  it { should belong_to :user }

  it do
    should validate_numericality_of(:quantity).
        is_greater_than_or_equal_to(0)
  end
end