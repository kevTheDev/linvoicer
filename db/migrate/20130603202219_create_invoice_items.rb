class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :client_id
      t.integer :invoice_id
      t.date :date
      t.time :start
      t.time :finish

      t.timestamps
    end
  end
end
