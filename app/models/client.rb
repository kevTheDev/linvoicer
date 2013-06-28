class Client < ActiveRecord::Base
  
  validates :name,  presence: true, uniqueness: true
  validates :hourly_rate, presence: true
  
  RATES = ['standard', 'training', 'supervision']
  
  def rate_for(rate_name)
    case rate_name.downcase
    when 'supervision'
      supervision_rate
    when 'training'
      training_rate
    else
      hourly_rate
    end
  end
  
  def self.work_types
    #[{ name: 'standard'}, { name: 'supervision'}, { name: 'training'}]
    RATES
  end
  
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

