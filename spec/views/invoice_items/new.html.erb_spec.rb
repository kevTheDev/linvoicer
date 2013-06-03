require 'spec_helper'

describe "invoice_items/new" do
  before(:each) do
    assign(:invoice_item, stub_model(InvoiceItem,
      :client_id => 1
    ).as_new_record)
  end

  it "renders new invoice_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", invoice_items_path, "post" do
      assert_select "input#invoice_item_client_id[name=?]", "invoice_item[client_id]"
    end
  end
end
