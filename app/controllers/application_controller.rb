class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  # before_filter :store_current_location, :unless => :devise_controller? #rediriger vers la dernière page visitée après authentification
  before_action :authenticate_user!, unless: :pages_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me, :avatar) }
   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me, :avatar) }
   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:avatar, :name, :description, :email, :password, :password_confirmation, :current_password) }
  end

  def default_url_options
    if Rails.env.production?
      { host: 'lofficedespotes.herokuapp.com' }
    elsif Rails.env.staging?
      { host: 'lofficedespotes-staging.herokuapp.com' }
    else
      { host: ENV['HOST'] || 'localhost:3000' }
    end
  end

  #rediriger vers la dernière page visitée après authentification
  # def store_current_location
  #   store_location_for(:user, request.url)
  # end

  def after_sign_in_path_for(resource)
    users_path
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      users_path
    else
      users_path || request.env['omniauth.origin'] || stored_location_for(resource) || request.referer
    end
  end

  # Uncomment these lines to get pundit
  # include Pundit
  # after_action :verify_authorized, except:  :index, unless: :devise_or_pages_or_admin_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_or_pages_or_admin_controller?
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  if Rails.env.production?
    before_filter :ensure_domain
  end

  private

  def ensure_domain
    # si l'url n'est pas en www il redirige vers l'url en www avec une redirection 301
    if request.env['HTTP_HOST'] != 'www.workuper.com'
      redirect_to "http://www.workuper.com#{request.env['REQUEST_PATH']}", :status => 301
    end
  end

  def devise_or_pages_or_admin_controller?
    devise_controller? || pages_controller? || params[:controller] =~ /^admin/
  end

  def pages_controller?
    controller_name == "pages"  # Brought by the `high_voltage` gem
  end

  def user_not_authorized
    flash[:error] = I18n.t('controllers.application.user_not_authorized', default: "Vous n'avez pas accès à cette page. Envoyez nous un message pour nous dire ce que vous recherchiez :)")
    redirect_to(root_path)
  end

  def check_privileges!
    redirect_to "/", notice: "Vous n'avez pas l'autorisation pour accéder à cette page, sorry..."  unless current_user.admin == true
  end

end
