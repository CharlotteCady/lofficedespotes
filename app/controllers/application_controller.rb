class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: :pages_controller?

  before_action :configure_permitted_parameters, if: :devise_controller?

   protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
     devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:picture, :name, :description, :email, :password, :password_confirmation, :current_password) }
   end

   def default_url_options
     if Rails.env.production?
       { host: 'lofficedespotes-production.herokuapp.com' }
     else
       { host: ENV['HOST'] || 'localhost:3000' }
     end
   end

  # Uncomment these lines to get pundit
  # include Pundit
  # after_action :verify_authorized, except:  :index, unless: :devise_or_pages_or_admin_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_or_pages_or_admin_controller?
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def devise_or_pages_or_admin_controller?
    devise_controller? || pages_controller? || params[:controller] =~ /^admin/
  end

  def pages_controller?
    controller_name == "pages"  # Brought by the `high_voltage` gem
  end

  def user_not_authorized
    flash[:error] = I18n.t('controllers.application.user_not_authorized', default: "You can't access this page.")
    redirect_to(root_path)
  end

  def check_privileges!
    redirect_to "/", notice: "Vous n'avez pas l'autorisation pour accéder à cette page, sorry..."  unless current_user.admin == true
  end
end
