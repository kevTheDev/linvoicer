class Client < ActiveRecord::Base
  
  validates :first_name,  presence: true
  validates :hourly_rate, presence: true
  
end