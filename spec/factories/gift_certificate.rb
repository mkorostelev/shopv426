FactoryGirl.define do
  factory :gift_certificate do
    token SecureRandom.uuid
  end
end