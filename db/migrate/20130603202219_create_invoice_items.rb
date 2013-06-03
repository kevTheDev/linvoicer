class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :client_id
      t.date :date
      t.time :start
      t.time :end

      t.timestamps
    end
  end
end
