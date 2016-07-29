require 'rails_helper'

RSpec.describe Balance, type: :model do
  it { should be_a ActiveModel::Validations }

  let(:user) {User.create name: 'test2', email: 'test2@test.com', password: '12345678'}

  let(:balance) { Balance.new(user).update! amount: '1'}

  let(:user) { stub_model User }

  subject { balance }

  its(:amount) { should eq 1 }
  its(:current_user) { should eq user }

  describe '#current_user' do
    it 'incremented balance' do
      expect(balance.current_user.balance).to eql(1)
    end
  end

  describe :update do
    context 'given amount less then 0' do
      it "raises a 'amount must be a positive integer' exception" do
        # expect { Balance.new(user).update! amount: '-1' }.to raise_error(ActiveModel::StrictValidationFailed)
        expect { balance.update! amount: '-1' }.to raise_error(ActiveModel::StrictValidationFailed)
      end
    end

    context 'without params' do
      it 'without errors' do
        # expect { Balance.new(user).update! amount: '-1' }.to raise_error(ActiveModel::StrictValidationFailed)
        expect { balance.update! }.to_not raise_error
      end
    end
  end

  it { expect(balance).to respond_to(:amount) }
  it { expect(balance).to respond_to(:current_user) }
end
