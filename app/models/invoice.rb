class Invoice < ActiveRecord::Base
  
  has_many :invoice_items, dependent: :destroy
  
  validates :month, presence: true
  validates :year, presence: true
  
  accepts_nested_attributes_for :invoice_items, allow_destroy: true
  
  def title
    "#{month} #{year}"
  end
  
  # TODO - NEeds to work with Big Decmials  
  def total
    invoice_items.collect { |item| item.total_cost }.inject(:+)
  end

  def total
    sum = 0
    invoice_items.each do |item|
      sum = (BigDecimal("#{sum}") + BigDecimal("#{item.total_cost}")).to_f
    end
    
    sum
  end
  
  def filename
    "Invoice #{month} #{year}.pdf"
  end
  
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

