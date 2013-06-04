require 'spec_helper'

describe InvoiceItem do
  
  describe 'Associations' do
    
    it { should belong_to(:client) }
    
    it { should belong_to(:invoice) }
    
  end
  # Associations
  
  
end

# == Schema Information
#
# Table name: invoice_items
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  invoice_id :integer
#  date       :date
#  start      :time
#  finish     :time
#  created_at :datetime
#  updated_at :datetime
#

