class InvoiceItem < ActiveRecord::Base
  
  belongs_to :client
  
  belongs_to :invoice
  
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

