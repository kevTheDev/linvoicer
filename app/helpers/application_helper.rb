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
  
end
