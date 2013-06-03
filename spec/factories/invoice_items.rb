# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice_item do
    client_id 1
    date "2013-06-03"
    start "2013-06-03 21:22:19"
    finish "2013-06-03 21:22:19"
  end
end
