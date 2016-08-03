require 'rails_helper'

RSpec.describe Api::PurchasesController, type: :controller do
  it { should route(:get, '/api/purchases').to(action: :index) }

  it { should route(:get, '/api/purchases/1').to(action: :show, id: 1) }
end
