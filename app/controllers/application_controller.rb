class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	before_filter :configure_permitted_parameters, if: :devise_controller?

	protected

  def configure_permitted_parameters
    if params.include?(:jury)
      params.require(:jury).permit!
    end
    if params.include?(:participant)
      params.require(:participant).permit!
    end
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :institution, :manager, :email, :password, :password_confirmation, :meta_type) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :institution, :manager, :email, :password, :password_confirmation, :current_password) }
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_url, alert: exception.message }
    end
  end
end
