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
end
