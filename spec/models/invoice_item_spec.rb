require 'spec_helper'

describe InvoiceItem do
  
  describe 'Associations' do
    
    it { should belong_to(:client) }
    
    it { should belong_to(:invoice) }
    
  end
  # Associations
  
  describe 'time_in_hours' do
    
    context 'zero time' do
    
      before do
        start_and_end = Time.now
        @invoice_item = build(:invoice_item, start: start_and_end, finish: start_and_end)
      end
      
      it 'returns zero' do
        @invoice_item.time_in_hours.should == 0
      end
    end
    # zero_time
    
    context 'only whole hours worked' do
      
      before do
        start  = Time.now
        finish = 1.hour.from_now(start)
        
        @invoice_item = build(:invoice_item, start: start, finish: finish)
      end
      
      it 'returns zero' do
        @invoice_item.time_in_hours.should == 1
      end
      
    end
    
    context 'fractional hours worked' do
      
      before do
        start         = Time.now
        hour_from_now = 1.hour.from_now
        finish        = 15.minutes.from_now(hour_from_now)
        
        @invoice_item = build(:invoice_item, start: start, finish: finish)
      end
      
      it 'returns zero' do
        @invoice_item.time_in_hours.should == 1.25
      end
      
      
    end
    
  end
  # time_in_hours
  
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

