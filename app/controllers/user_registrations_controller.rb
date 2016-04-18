class UserRegistrationsController < Devise::RegistrationsController
  def create

    meta_type = params[:user][:meta_type]

    params[:user].delete(:meta_type)

    build_resource(sign_up_params)

    child_class = meta_type.camelize.constantize
    resource.meta = child_class.new(params[child_class.to_s.underscore.to_sym])

    # first check if child intance is valid
    # cause if so and the parent instance is valid as well
    # it's all being saved at once
    valid = resource.valid?
    valid = resource.meta.valid? && valid

    # customized code end
    yield resource if block_given?# customized code
    if valid && resource.save
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          redirect_to root_path
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        @validatable = devise_mapping.validatable?
        if @validatable
          @minimum_password_length = resource_class.password_length.min
        end
        respond_with resource
      end
    else
      render :create
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated && resource.meta.update_attributes(user_params)
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      render :edit
    end
  end

  protected

  def user_params
    if params.has_key? :participant
      return params.require(:participant).permit(
        :manager, :classroom)
    end

    if params.has_key? :jury
      return params.require(:jury).permit(
          :middle_name, :rank, :degree)
    end
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_update_path_for(resource)
    super
  end
end