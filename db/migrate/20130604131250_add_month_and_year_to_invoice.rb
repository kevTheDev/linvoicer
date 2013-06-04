class AddMonthAndYearToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :month, :string, limit: 20
    add_column :invoices, :year,  :integer
  end
end
