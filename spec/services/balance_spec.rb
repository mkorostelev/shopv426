require 'rails_helper'

RSpec.describe Balance, type: :model do
  # it { should be_a ActiveModel::Validations }

  let(:user) {User.create name: "test2", email: 'test2@test.com', password: '12345678'}

  let(:balance) { Balance.new(user).update! amount: '1000'}

  let(:user) { stub_model User }

  subject { balance }

  its(:amount) { should eq 1000 }
  its(:current_user) { should eq user }

  describe "#current_user" do

    it "incremented balance" do
      expect(balance.current_user.balance).to eql(1000)
    end
  end

  describe "update" do

    context "given amount less then 0" do

      it "raises a 'amount must be greater than or equal to 0' exception" do
        expect { Balance.new(user).update! amount: '-1000' }.to raise_error('must be greater than or equal to 0')
      end
    end
  end

  #
  # its(:decorate) { should eq subject }
  #
  # describe '#user' do
  #   before { expect(User).to receive(:find_by).with(email: 'test@test.com') }
  #
  #   it { expect { subject.send :user }.to_not raise_error }
  # end
  #
  # context 'validations' do
  #   subject { session.errors }
  #
  #   context do
  #     before { expect(session).to receive(:user) }
  #
  #     before { session.valid? }
  #
  #     its([:email]) { should eq ['not found'] }
  #   end
  #
  #   context do
  #     before { expect(session).to receive(:user).twice.and_return(user) }
  #
  #     before { expect(user).to receive(:authenticate).with('12345678').and_return(false) }
  #
  #     before { session.valid? }
  #
  #     its([:password]) { should eq ['is invalid'] }
  #   end
  # end
  #
  # describe '#save!' do
  #   context do
  #     before { expect(subject).to receive(:valid?).and_return(false) }
  #
  #     it { expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed) }
  #   end
  #
  #   context do
  #     before { expect(subject).to receive(:user).and_return(user) }
  #
  #     before { expect(subject).to receive(:valid?).and_return(true) }
  #
  #     before { expect(SecureRandom).to receive(:uuid).and_return('XXXX-YYYY-ZZZZ') }
  #
  #     before { expect(user).to receive(:create_auth_token).with(value: 'XXXX-YYYY-ZZZZ') }
  #
  #     it { expect { subject.save! }.to_not raise_error }
  #   end
  # end
  #
  # describe '#destroy!' do
  #   before do
  #     expect(subject).to receive(:user) do
  #       double.tap do |a|
  #         expect(a).to receive(:auth_token) do
  #           double.tap do |b|
  #             expect(b).to receive(:destroy!)
  #           end
  #         end
  #       end
  #     end
  #   end
  #
  #   it { expect { subject.destroy! }.to_not raise_error }
  # end
  #
  # describe '#auth_token' do
  #   context do
  #     before { expect(subject).to receive(:user) }
  #
  #     its(:auth_token) { should eq nil }
  #   end
  #
  #   context do
  #     let(:auth_token) { stub_model AuthToken, value: 'XXXX-YYYY-ZZZZ' }
  #
  #     let(:user) { stub_model User, auth_token: auth_token }
  #
  #     before { expect(subject).to receive(:user).and_return(user) }
  #
  #     its(:auth_token) { should eq 'XXXX-YYYY-ZZZZ' }
  #   end
  # end
  #
  # describe '#as_json' do
  #   before { expect(subject).to receive(:auth_token).and_return('XXXX-YYYY-ZZZZ') }
  #
  #   its(:as_json) { should eq auth_token: 'XXXX-YYYY-ZZZZ' }
  # end
end
