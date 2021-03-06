class InvoiceWriter
  
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper
  
  
  def initialize(invoice)
    @invoice = invoice
    @invoice_items = invoice.invoice_items.order('date ASC')
  end
  
  def write
    # Implicit Block
    Prawn::Document.generate(@invoice.filename) do |pdf|
      
      font = 'Times-Roman'

      pdf.text "Larissa Koutakos"
      pdf.text "31 Milton Road, Walton-on- Thames, Surrey, KT12 3HB"

      pdf.image "#{Rails.root}/app/assets/images/bcc_logo.jpg", :at => [400, pdf.cursor]
      
      pdf.move_down 120
      
      
      
      pdf.font font, :size => 25, :style => :bold do
        pdf.draw_text "INVOICE", :at => [400, pdf.cursor]
      end
      
      pdf.move_down 20
      
      pdf.font font, :size => 12, :style => :bold do
        pdf.draw_text "Date: #{@invoice.date.strftime('%d/%m/%Y')}", :at => [400, pdf.cursor]
      end

      pdf.move_down 25
      
      pdf.table(item_rows, width: 500)
      
      pdf.move_down 25



      payment_details(pdf)
    end
  end
  
  private
  
  def payment_details(pdf)
    pdf.draw_text "TO PAY BY BACS", :at => [400, pdf.cursor]
    pdf.move_down 15
    pdf.draw_text "ACCT NAME: L F KOUTAKOS", :at => [335, pdf.cursor]
    pdf.move_down 15
    pdf.draw_text "SORT CODE: 089249", :at => [380, pdf.cursor]
    pdf.move_down 15
    pdf.draw_text "ACCT NUMBER: 11349242", :at => [350, pdf.cursor]
  end
  
  def invoice_formatted_date(date)
    date.strftime('%d/%m/%y')
  end
  
  def item_rows
    rows = [["Child Name", "Date", "Hours", 'Petrol', 'Total']]
    
    client_invoice_items = @invoice_items.group_by(&:client_id)
    
    puts "CLIENT ITEMS: #{client_invoice_items}"
    
    
    puts "NUMBER OF CLIENTS: #{client_invoice_items.keys.count}"
    
    client_invoice_items.each_key do |client_id|
      
      invoice_items = client_invoice_items[client_id]
      
      invoice_items.each do |invoice_item|
        puts "INVOICE ITEM CLIENT: #{invoice_item.client.name}"
        
        rows << [invoice_item.client.name, invoice_formatted_date(invoice_item.date), invoice_item.hours_string, rounded_value(invoice_item.petrol), rounded_value(invoice_item.total_cost)]
      end
      
      rows << ['', '', "#{@invoice.hours_for_client(client_id)} hours", '', "#{@invoice.total_for_client(client_id)}"]
    end
    
    rows << ['', '', '', '', "Total: £#{@invoice.total}"]
    rows
  end
  
  def claimants(pdf)
    @claim.claimants.each do |claimant|
      pdf.text "Name: #{claimant_contact_detail(claimant, :full_name_and_title, @claim)}"
      pdf.text "Address: #{claimant_contact_detail(claimant, :one_line_address, @claim)}"
      pdf.move_down 20
    end
  end
  
  def header(pdf, font)
    y_position = pdf.cursor
    pdf.image "#{Rails.root}/app/assets/images/logo_eu_delay_trimmed_320.png", :at => [50, y_position]
    
    y_position = y_position - 40
    
    pdf.font font, :size => 25, :style => :bold do
      pdf.draw_text "Power of Attorney", :at => [300, y_position]
    end
    
    y_position = y_position - 40
    
    pdf.font font, size: 14, style: :bold do
      pdf.draw_text "THE PRINCIPAL", :at => [200, y_position]
    end
    
    y_position = y_position - 10
    pdf.font font, size: 8, style: :bold do
      pdf.draw_text "(The Principal can be one or more persons)", :at => [180, y_position]
    end
    
    pdf.move_down 120
    
    pdf.text "Claim reason: #{human_readable_reason(@claim) }"
    pdf.move_down 10
  end
  
  def footer(pdf, font)
    pdf.move_down 20
    
    pdf.font font, size: 14, style: :bold do
      pdf.draw_text "FLIGHT INFORMATION", :at => [200, pdf.cursor]
    end
    
    pdf.move_down 10
    
    if @claim.flight_number.present?
      pdf.text "Flight number: #{@claim.flight_number}"
    end
    
    if @claim.carrier.present?
      pdf.text "Carrier: #{@claim.carrier.name}"
    end
    
    pdf.text "Departure date: #{@claim.departed_at.strftime('%d %B %Y')}"
    
    pdf.text "Departure Airport: #{@claim.departure_airport.name}" if @claim.departure_airport
    pdf.text "Arrival Airport: #{@claim.arrival_airport.name}"   if @claim.arrival_airport
    
    pdf.move_down 30
    
    pdf.font font, size: 14, style: :bold do
      pdf.draw_text "POWER OF ATTORNEY", :at => [200, pdf.cursor]
    end
    pdf.move_down 20
    
    pdf.text "I, the Principal, hereby authorize EUDELAY, ltd. with registered address at 30 Church Road, Burgess Hill, RH15 9AE, United Kingdom represented by managing director Jakub Kotan (hereafter \"Attorney\") to act on my behalf in assessing my claim and seeking compensation under the Regulation (EC) 261/2004 of the European Parliament and of the Council from the air carrier in connection to the above mentioned flight. The Principal appoints the Attorney to communicate with all relevant parties, prepare, sign, submit and file documents including the EU Complaint Form, seek legal action, claim and receive money on the Principal\'s behalf."
    pdf.move_down 10
    
    pdf.text "I understand that Civil Aviation Authorities (\"CAA\") in the EU will provide assistance and advice free of charge. I can deal direct with the CAA to handle my complaint.  However I confirm I will be using EUDELAY and authorise them to contact the relevant CAA for assistance with my complaint if necessary."
    
    pdf.move_down 10
    pdf.text "The Attorney may represent all signatories to this Power of Attorney individually."
  end
  
  # HelloSign automatically adds a place for each claimant to sign
  # If the client is signing with an uploaded document, we must manually
  # add a place for each client to sign and date
  def add_signature_boxes(pdf, font)
    pdf.move_down 40
    
    pdf.start_new_page
    
    pdf.font font, size: 14, style: :bold do
      pdf.draw_text "SIGNATURE PAGE", :at => [200, pdf.cursor]
    end
  
    pdf.move_down 40
  
    @claim.poa_signers.each do |signer|
      add_signature_box(pdf, font, signer)
      pdf.move_down 40
    end
  end
  
  def add_signature_box(pdf, font, signer)
    pdf.stroke do
      pdf.font font, size: 14, style: :bold do
        pdf.draw_text "Signature: #{signer.full_name_and_title}", :at => [0, pdf.cursor]
        pdf.draw_text "Date", :at => [320, pdf.cursor]
        
        
        pdf.move_down 40
        
        pdf.draw_text ".....................................................", :at => [0, pdf.cursor]
        pdf.draw_text ".....................................................", :at => [320, pdf.cursor]
      end
      
      
      
      
    
      #pdf.rectangle [0, pdf.cursor], 280, 80
      #pdf.rectangle [320, pdf.cursor], 180, 80
    end
  end

end