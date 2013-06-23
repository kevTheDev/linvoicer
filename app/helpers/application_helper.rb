module ApplicationHelper
  
  def years_for_select
    start_year = Time.now.year
    (start_year - 2..start_year + 2).to_a
  end
  
  def link_to_add_fields(name, f, association, parent_object)
#    Rails.logger.info "Fobject: #{parent_object}"
    #parent_object = Invoice.find(parent_object)
    
    new_object = parent_object.send(association).klass.new
    id = new_object.object_id
    
    partial_name = "#{association.to_s.singularize}_fields"
    
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(partial: partial_name, locals: {f: builder, parent_object: parent_object})
    end
    
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  
  def link_button(title, path, options={})
    link_to title, path, options.merge(:class => 'btn btn-primary')
  end

  def submit_button(f, title, options={})
    f.submit title, options.merge(:class => 'btn btn-primary')
  end

  def danger_submit_button(f, title, options={})
    f.submit title, options.merge(:class => 'btn btn-danger')
  end

  def danger_submit_button_large(f, title, options={})
    f.submit title, options.merge(:class => 'btn btn-large btn-danger')
  end

  def success_submit_button(f, title, options={})
    f.submit title, options.merge(:class => 'btn btn-success')
  end

  def success_link_button(title, path, options={})
    link_to title, path, options.merge(:class => 'btn btn-success')
  end

  def success_link_button_large(title, path, options={})
    link_to title, path, options.merge(:class => 'btn btn-large btn-success')
  end

  def danger_link_button(title, path, options={})
    link_to title, path, options.merge(:class => 'btn btn-danger')
  end

  def formatted_time(date_time)
    date_time.try(:strftime, '%d %B %Y %H:%M')
  end

  def formatted_date(date)
    date.try(:strftime, '%d %B %Y')
  end
end
