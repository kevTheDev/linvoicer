class InvoiceItem < ActiveRecord::Base
  
  belongs_to :client
  
  belongs_to :invoice
  
  validates :client, presence: true
  validates :date, presence: true
  validates :start, presence: true
  validates :finish, presence: true
  
  def self.allowed_attributes
    [:client_id, 'date(1i)', 'date(2i)', 'date(3i)', 'start(1i)', 'start(2i)', 'start(3i)', 'finish(1i)', 'finish(2i)', 'finish(3i)', :petrol, :date, :start, :finish, :work_type]
  end

  # http://stackoverflow.com/questions/14903379/rounding-to-nearest-fraction-half-quarter-etc  
  
  # returns the duration to the nearest quarter hour
  def time_in_hours
    return 0 if start == finish
    
    difference = (finish - start) / 1.hour
    floor = (difference * 4).floor
    floor / 4.0
  end
  
  def rate
    client.rate_for(work_type)
  end
  
  def cost
    time_in_hours * client.rate_for(work_type)
  end
  
  def total_cost
    (cost + petrol).to_f
  end
  
  def hours_string
    "#{hour_string(start)} - #{hour_string(finish)}"
  end
  
  def hour_string(time)
    time.strftime('%H:%M')
  end
    
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

