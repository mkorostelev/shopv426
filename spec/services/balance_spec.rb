require 'rails_helper'

RSpec.describe Balance, type: :model do

  let(:user) { stub_model User, balance: 0, bonus_points: 0 }

  subject { Balance.new(user) }

  it { should be_a(ActiveModel::Validations) }


  describe '#valid?' do
    # balance.user.valid?
    context do
      before do
        expect(subject).to receive(:user) do
          double.tap { |a| expect(a).to receive(:valid?).and_return true }
        end
      end

      it { expect(subject.valid?).to eq true }
    end

    context do
      before do
        expect(subject).to receive(:user) do
          double.tap { |a| expect(a).to receive(:valid?).and_return false }
        end
      end

      # balance.user.errors.full_messages
      before do
        expect(subject).to receive(:user) do
          double.tap do |a|
            expect(a).to receive(:errors) do
              double.tap { |b| expect(b).to receive(:full_messages).and_return(["error"]) }
            end
          end
        end
      end

      context do
        it { expect(subject.valid?).to eq false }
      end

      context do
        before { subject.valid? }

        it { expect(subject.errors.full_messages).to eq ["User Error: error"] }
      end
    end
  end


  describe '#decorate' do
    # user.decorate
    before do
      expect(subject).to receive(:user) do
        double.tap { |a| expect(a).to receive(:decorate) }
      end
    end

    it { expect { subject.decorate }.to_not raise_error }
  end

  describe '#update!' do
    # params = params&.symbolize_keys || {}

    # @amount = params[:amount].to_i

    # @bonus_points = params[:bonus_points].to_i

    # user.increment(:balance, amount)

    # user.increment(:bonus_points, bonus_points)

    # user.save

    # raise ActiveModel::StrictValidationFailed unless valid?

    let(:params) { { "amount" => "2", "bonus_points" => "5" } }

    before { expect(user).to receive(:increment).with(:balance, 2) }

    before { expect(user).to receive(:increment).with(:bonus_points, 5) }

    before { expect(user).to receive(:save) }

    context do
      before { expect(subject).to receive(:valid?).and_return true }

      it { expect { subject.update!(params) }.to_not raise_error }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return false }

      it { expect { subject.update!(params) }.to raise_error ActiveModel::StrictValidationFailed }
    end
  end
end
