require 'spec_helper'

describe "invoice_items/edit" do
  before(:each) do
    @invoice_item = assign(:invoice_item, stub_model(InvoiceItem,
      :client_id => 1
    ))
  end

  it "renders the edit invoice_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", invoice_item_path(@invoice_item), "post" do
      assert_select "input#invoice_item_client_id[name=?]", "invoice_item[client_id]"
    end
  end
end
