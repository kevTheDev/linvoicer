require 'spec_helper'

describe Client do
  
  describe 'Validations' do
    
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:hourly_rate) }
    
  end
  # Validations
  
  
end