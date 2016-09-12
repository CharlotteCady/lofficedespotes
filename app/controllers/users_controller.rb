class UsersController < ApplicationController
  before_filter :check_privileges!, only: [:index]

  CATEGORIES = ["Trouver sa voie", "Trouver un job", "Changer de métier", "Changer de boite", "Créer sa boite", "Coup de Coeur"]
  SUBCATEGORIES = ["S'inspirer", "S'informer", "Se Faire Aider", "Se Former", "Réseauter", "Postuler", "Profiter"]

  def show
  end

  def favorites
    @categories = CATEGORIES
    @subcategories = SUBCATEGORIES
    @category = params[:category]
    @ressources = Ressource.where(category: @category)
    @user_cat_vote = @ressources.map { |r| current_user.voted_up_on? r }
    @all_ressources = Ressource.all.order('created_at DESC')
    @user_vote = @all_ressources.map { |r| current_user.voted_up_on? r }
  end

  def matching
    array_ressources_matching = []
    if current_user.category != nil
      array_category_user = eval(current_user.category)
    end
    if current_user.profil != nil
      array_profil_user = eval(current_user.profil)
    end
    if current_user.tag != nil
      array_tag_user = eval(current_user.tag)
    end

    Ressource.all.each do |ress|
      if ress.profil.present?
        if array_category_user != nil
          match_category = eval(ress.category) & array_category_user
          match_profil = eval(ress.profil) & array_profil_user
          if (match_category != []) && (match_profil != [])
            array_ressources_matching << ress
          end
        end
      end
    end
    Ressource.all.each do |ress|
      if ress.tag.present?
        if array_tag_user != nil
          match_tag = eval(ress.tag) & array_tag_user
          if (match_tag != [])
            unless array_ressources_matching.include?(ress)
              array_ressources_matching << ress
            end
          end
        end
      end
    end

      @ressources = array_ressources_matching
  end

  def offer
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

  def update
    current_user.update(user_params)
    redirect_to matching_users_path
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
     params.require(:user).permit(:name, :description, :avatar, :password, :password_confirmation, :birthday, :city, :email, :remember_me, :profil => [], :category => [], :tag => [])
   end
end
