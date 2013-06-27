class AddPetrolToInvoiceItems < ActiveRecord::Migration
  def change
    add_column :invoice_items, :petrol, :float, default: 0
  end
end
