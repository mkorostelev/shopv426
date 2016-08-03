require 'rails_helper'

RSpec.describe Api::GiftCertificatesController, type: :controller do
  it { should route(:get, '/api/gift_certificates').to(action: :index) }

  it { should route(:get, '/api/gift_certificates/1').to(action: :show, id: 1) }

  describe 'GET new' do
    let(:gift_certificate) { GiftCertificate.new }
    it 'assign new gift_certificate controller to @gift_certificate' do
      expect(gift_certificate).to be_a_new(GiftCertificate)
    end
  end

  # it do
  #   params = {
  #       gift_certificate: {
  #           order_id: nil,
  #           amount: 1
  #       }
  #   }
  #   should permit(:order_id, :amount).for(:create, params: params).on(:gift_certificate)
  # end

  describe '#create.json' do
    let(:params) do
      {
          amount: 1
      }
    end

    let(:gift_certificate) { stub_model GiftCertificate }

    before  { expect(GiftCertificate).to receive(:new).with(params).and_return(gift_certificate) }

    before  { expect(gift_certificate).to receive(:save!) }

    before  { post :create, gift_certificate: params, format: :json }

    # it { should render_template :create }
  end

end
