module ApplicationHelper
  def link_to_add_fields(name, f, association, button_class=nil, container_id=nil)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    if container_id == nil
      container_id = association
    end
    container_id_css_spec = '#' + container_id
    opts = { class: 'add_fields', data: { id: id, container: container_id_css_spec, fields: fields.gsub("\n",'') } }
    if button_class != nil
      opts['class'] = "add_fields #{button_class}"
    end
    link_to(name, '#', opts)
  end

  def decimals(a)
    num = 0
    while(a != a.to_i)
      num += 1
      a *= 10
    end
    num
  end
end
