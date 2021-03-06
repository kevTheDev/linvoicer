require 'spec_helper'

describe Client do
  
  describe 'Validations' do
    
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:hourly_rate) }
    
    it { should validate_uniqueness_of(:name) }
    
  end
  # Validations
  
  
end

# == Schema Information
#
# Table name: clients
#
#  id          :integer          not null, primary key
#  first_name  :string(255)
#  hourly_rate :float
#  created_at  :datetime
#  updated_at  :datetime
#

