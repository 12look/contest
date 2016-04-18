ActiveAdmin.register User do
  menu label: 'Пользователи'
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

  scope :all, default: true
  scope :participants
  scope :not_active_jury

  permit_params :first_name, :last_name, :email, :institution, :manager, :meta_type,
                role_ids: [], meta_attributes: [:manager, :classroom, :middle_name, :rank, :degree]

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
  f.inputs 'Информация об участнике' do
    f.input :first_name
    f.input :last_name
    f.input :institution
    f.input :email
    f.input :roles
  end

  if f.object.new_record?
    f.inputs 'Type' do
      f.input :meta_type, input_html: {class: 'polyselect'},
              collection: User::META_TYPES
    end
  end

  if !f.object.meta || f.object.meta_type == 'Participant'
    f.inputs 'Участник', for: [:meta, f.object.meta || Participant.new],
             id: 'Participant_poly', class: "inputs #{'polyform' if f.object.new_record?}" do |fc|
      fc.input :manager
      fc.input :classroom
    end
  end

  if !f.object.meta || f.object.meta_type == 'Jury'
    f.inputs 'Жюри', for: [:meta, f.object.meta || Jury.new],
             id: 'Jury_poly', class: "inputs #{'polyform' if f.object.new_record?}" do |fc|
      fc.input :middle_name
      fc.input :rank
      fc.input :degree
    end
  end

    f.actions
end

end
