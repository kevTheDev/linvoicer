require 'spec_helper'

describe InvoiceItem do
  
  describe 'Associations' do
    
    it { should belong_to(:client) }
    
    it { should belong_to(:invoice) }
    
  end
  # Associations
  
  
end
