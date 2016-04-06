ActiveAdmin.register Work do

  menu label: "Работы"
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :name, :description, :file, :user_id, :category_id,
               images_attributes: [:id, :image, :_destroy]
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
show do |work|
   attributes_table do
     row :user do
       "#{work.user.first_name} #{work.user.last_name}"
     end
     row :category
     row :description
     row :file do
       work.file? ? image_tag(work.file.url, height: '100') : content_tag(:span, "No photo yet")
     end
   end
end

index do
  selectable_column
  id_column
  column :name
  column :description
  column :created_at
  column :category
  column :user
  actions
end

form do |f|
  f.semantic_errors
  f.inputs "Детали работы" do
    f.input :user, member_label: Proc.new { |c| "#{c.first_name} #{c.last_name}" }
    f.input :category
    f.input :file, hint: work.file? ? image_tag(work.file.url, height: '100') : content_tag(:span, "Upload JPG/PNG/GIF image")
    f.input :name
    f.input :description
  end
  f.inputs "Доп скрины" do
    f.has_many :images do |p|
      p.input :image, as: :file, label: "Image", hint: p.object.image.nil? ? p.template.content_tag(:span, "No Image Yet") : p.template.image_tag(p.object.image.url(:thumb))
      p.input :_destroy, as: :boolean, required: false, label: 'Удалить'
    end
  end
  f.actions
end

end
