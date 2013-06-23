class Client < ActiveRecord::Base
  
  validates :name,  presence: true, uniqueness: true
  validates :hourly_rate, presence: true
  
end

# == Schema Information
#
# Table name: clients
#
#  id          :integer          not null, primary key
#  name  :string(255)
#  hourly_rate :float
#  created_at  :datetime
#  updated_at  :datetime
#

