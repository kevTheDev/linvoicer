module ApplicationHelper
  
  def nice_date(date)
    date.strftime('%d/%b/%Y')
  end
  
  def years_for_select
    start_year = Time.now.year
    (start_year - 2..start_year + 2).to_a
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
  
  def rounded_value(value)
    #value.round(2)
    number_with_precision(value, precision: 2)
  end
    
end
