class UsersController < ApplicationController
  before_filter :check_privileges!, only: [:index]

  def show
  end

  def favorites
    @categories = ["Chercher un job", "Changer de métier", "Changer de boite", "Créer sa boite", "Intraprendre", "Coup de Coeur"]
    @subcategories = ["S'inspirer", "S'informer", "Se Faire Aider", "Se Former", "Réseauter", "Postuler", "Profiter"]
    @category = params[:category]
    @ressources = Ressource.where(category: @category)
    @user_cat_vote = @ressources.map { |r| current_user.voted_up_on? r }
    @all_ressources = Ressource.all.order('created_at DESC')
    @user_vote = @all_ressources.map { |r| current_user.voted_up_on? r }
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
      redirect_to root_url, notice: "Utilisateur effacé"
    end
  end

  def edit
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to users_path
    else
      render "edit"
    end
  end

  private

   def user_params
     # NOTE: Using `strong_parameters` gem
     params.require(:user).permit(:password, :password_confirmation)
   end
end
