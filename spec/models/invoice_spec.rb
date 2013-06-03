require 'spec_helper'

describe Invoice do
  
  describe 'Associations' do
    
    it { should have_many(:invoice_items) }
    
  end
  # Associations
  
end
