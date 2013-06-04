module ApplicationHelper
  
  def years_for_select
    start_year = Time.now.year
    (start_year - 2..start_year + 2).to_a
  end
  
end
