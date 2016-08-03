require 'rails_helper'

RSpec.describe GiftCertificate, type: :model do
  it { should belong_to :order }

  it { should_not validate_presence_of :token }
end
