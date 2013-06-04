require 'spec_helper'

describe Invoice do
  
  describe 'Associations' do
    
    it { should have_many(:invoice_items) }
    
  end
  # Associations
  
  describe 'Validations' do
    
    it { should validate_presence_of(:month) }
    it { should validate_presence_of(:year) }
    
  end
  # Validations
  
end
