class Invoice < ActiveRecord::Base
  
  has_many :invoice_items, dependent: :destroy
  
  validates :month, presence: true
  validates :year, presence: true
  
  def title
    "#{month} #{year}"
  end
  
end
