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
  
  describe '#title' do
    
    subject { create(:invoice, month: 'May', year: 2014) }
    
    it 'should contain the month and year' do
      subject.title.include?('May').should == true
      subject.title.include?('2014').should == true
    end
    
  end
  # title
  
  describe '#total' do
    
    before do
      @invoice = build(:invoice)
      
      item_1 = build(:invoice_item, invoice: @invoice)
      item_2 = build(:invoice_item, invoice: @invoice)
      
      item_1.stub(:total_cost) { 52.30 }
      item_2.stub(:total_cost) { 23.60 }
      
      @invoice.stub(:invoice_items) { [item_1, item_2] }
    end
    
    it 'returns the sum of all invoice_items#total_cost' do
      @invoice.total.should == 75.90
    end
    
  end
  # total
end

# == Schema Information
#
# Table name: invoices
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  month      :string(20)
#  year       :integer
#

