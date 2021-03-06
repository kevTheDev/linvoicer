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
  
  def hours_for_client(client_id)
    items_for_client(client_id).collect { |item| item.time_in_hours }.inject(:+)
  end
  
  def total_for_client(client_id)
    sum = 0
    items_for_client(client_id).each do |item|
      sum = (BigDecimal("#{sum}") + BigDecimal("#{item.total_cost}")).to_f
    end
    
    sum
  end
  
  def items_for_client(client_id)
    invoice_items.where(client_id: client_id)
  end
  
  def date
    DateTime.parse("#{month} #{year}").end_of_month
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

