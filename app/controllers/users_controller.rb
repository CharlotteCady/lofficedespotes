class UsersController < ApplicationController
  before_filter :check_privileges!, only: [:index]

  def show
  end

  def favorites
    @categories = ["Chercher un job", "Changer de métier", "Changer de boite", "Créer sa boite", "Intraprendre"]
    @subcategories = ["S'inspirer", "S'informer", "Se Faire Aider", "Se Former", "Réseauter", "Postuler", "S'éclater"]
    @category = params[:category]
    @ressources = Ressource.where(category: @category)
    @user_cat_vote = @ressources.map { |r| current_user.voted_up_on? r }
    @all_ressources = Ressource.all.order('created_at DESC')
    @user_vote = @all_ressources.map { |r| current_user.voted_up_on? r }
  end

  # def edit
  # end

  # def update
  #     current_user = User.find(:id)
  #     current_user.update(user_params)
  # end

  # private
  # def user_params
  #   params.require(:user).permit(:name, :picture, :email, :password)
  # end
end
