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
  
  describe 'cost' do
    
    context 'integer hourly_rate' do
      
      before do
        @client = create(:client, hourly_rate: 6)
      end
    
      context 'time_in_hours == 0' do
      
        before do
          @invoice_item = build(:invoice_item, client: @client)
          @invoice_item.stub(:time_in_hours) { 0 }
        end
      
        it 'returns 0' do
          @invoice_item.cost.should == 0
        end
        
      end
      # time_in_hours == 0
      
      context 'time_in_hours is integer' do
      
        before do
          @invoice_item = build(:invoice_item, client: @client)
          @invoice_item.stub(:time_in_hours) { 1 }
        end
      
        it 'returns the hourly_rate multiplied by the time' do
          @invoice_item.cost.should == 6
        end
        
      end
      # time_in_hours is integer
      
      context 'time_in_hours is float' do
      
        before do
          @invoice_item = build(:invoice_item, client: @client)
          @invoice_item.stub(:time_in_hours) { 1.25 }
        end
      
        it 'returns the hourly_rate multiplied by the time' do
          @invoice_item.cost.should == 7.5
        end
        
      end
      # time_in_hours is float
      
    end
    # integer hourly_rate
    
    context 'float hourly_rate' do
      
      before do
        @client = create(:client, hourly_rate: 6.50)
      end
    
      context 'time_in_hours == 0' do
      
        before do
          @invoice_item = build(:invoice_item, client: @client)
          @invoice_item.stub(:time_in_hours) { 0 }
        end
      
        it 'returns 0' do
          @invoice_item.cost.should == 0
        end
        
      end
      # time_in_hours == 0
      
      context 'time_in_hours is integer' do
      
        before do
          @invoice_item = build(:invoice_item, client: @client)
          @invoice_item.stub(:time_in_hours) { 1 }
        end
      
        it 'returns the hourly_rate multiplied by the time' do
          @invoice_item.cost.should == 6.5
        end
        
      end
      # time_in_hours is integer
      
      context 'time_in_hours is float' do
      
        before do
          @invoice_item = build(:invoice_item, client: @client)
          @invoice_item.stub(:time_in_hours) { 1.25 }
        end
      
        it 'returns the hourly_rate multiplied by the time' do
          @invoice_item.cost.should == 8.125
        end
        
      end
      # time_in_hours is float
      
    end
    # float hourly_rate
    
  end
  # cost
  
  describe 'total_cost' do
    
    context 'zero petrol' do
      
      before do
        @invoice_item = build(:invoice_item, petrol: 0)
        @invoice_item.stub(:cost) { 60 }
      end
      
      it 'returns cost' do
        @invoice_item.total_cost.should == 60
      end
    end
    # zero petrol
    
    context 'with petrol' do
      before do
        @invoice_item = build(:invoice_item, petrol: 5.0)
        @invoice_item.stub(:cost) { 60 }
      end
      
      it 'returns cost' do
        @invoice_item.total_cost.should == 65.0
      end
      
    end
    # with petrol
    
  end
  # total
  
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

