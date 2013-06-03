require 'spec_helper'

describe "invoice_items/show" do
  before(:each) do
    @invoice_item = assign(:invoice_item, stub_model(InvoiceItem,
      :client_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
