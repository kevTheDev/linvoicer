# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do
    sequence(:name) { |n| "client_#{n}" }
    hourly_rate 19.2
  end
end
