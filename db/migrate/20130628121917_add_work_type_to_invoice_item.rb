class AddWorkTypeToInvoiceItem < ActiveRecord::Migration
  def change
    add_column :invoice_items, :work_type, :string, default: 'standard'
  end
end
