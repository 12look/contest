ActiveAdmin.register User do
  menu label: "Участники"
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :first_name, :last_name, :email,
                role_ids: []

  after_create { |user| user.send_reset_password_instructions }
  def password_required?
    new_record? ? false : super
  end

index do
  selectable_column
  id_column
  column :email
  column :first_name
  column :last_name
  column :roles do |role|
    role.roles.map { |r| r.name }.join(" ")
  end
  column :sign_in_count
  column :created_at
  actions
end

form do |f|
  f.semantic_errors
  f.inputs "Информация об участнике" do
    f.input :first_name
    f.input :last_name
    f.input :email
    f.input :roles
  end
    f.actions
end

end
