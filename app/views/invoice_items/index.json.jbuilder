json.array!(@invoice_items) do |invoice_item|
  json.extract! invoice_item, :client_id, :date, :start, :end
  json.url invoice_item_url(invoice_item, format: :json)
end