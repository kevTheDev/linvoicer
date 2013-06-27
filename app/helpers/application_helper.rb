module ApplicationHelper
  
  def years_for_select
    start_year = Time.now.year
    (start_year - 2..start_year + 2).to_a
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
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
