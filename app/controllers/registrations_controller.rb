class Users::RegistrationsController < Devise::RegistrationsController
  def after_inactive_sign_up_path_for(resource_or_scope)
    # session["user_return_to"] || ressources_path
    redirect_to new_user_session_path
  end
end