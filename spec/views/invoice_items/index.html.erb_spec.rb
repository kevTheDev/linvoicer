require 'spec_helper'

describe "invoice_items/index" do
  before(:each) do
    assign(:invoice_items, [
      stub_model(InvoiceItem,
        :client_id => 1
      ),
      stub_model(InvoiceItem,
        :client_id => 1
      )
    ])
  end

  it "renders a list of invoice_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
