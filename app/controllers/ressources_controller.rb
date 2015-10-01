class RessourcesController < ApplicationController
  before_action :set_ressource, only: [:show, :edit, :update, :destroy]
  before_filter :check_privileges!, only: [:new, :create, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:index, :show]

  def index
    category = params[:category]
    subcategory = params[:subcategory]
    keyword = params[:search]
    if keyword || category || subcategory
      @ressources = Ressource.search(keyword, category, subcategory)
    else
      @ressources = Ressource.all.order('created_at DESC')
    end

    @categories = ["Chercher un job", "Changer de métier", "Changer de boite", "Créer sa boite", "Intraprendre"]
    @subcategories = ["S'inspirer", "S'informer", "Se Faire Aider", "Se Former", "Réseauter", "Postuler", "S'éclater"]
    @subcat_sidebar = ["Voir tout"]
  end

  # def search
  #   @key_word = params[:search][:query]
  #   @ressources = Ressource.where("title ILIKE ? or content ILIKE ?", @key_word, @key_word)
  # end

  def show
    @categories = ["Chercher un job", "Changer de métier", "Changer de boite", "Créer sa boite", "Intraprendre"]
    @subcategories = ["S'inspirer", "S'informer", "Se Faire Aider", "Se Former", "Réseauter", "Postuler", "S'éclater"]
    @subcat_sidebar = ["Voir tout"]
    @comment = @ressource.comments.new
    @comments = Comment.where(commentable_id: @ressource)
    @mois = %w( Janvier Février Mars Avril Mai Juin Juillet Août Septembre Octobre Novembre Décembre )
    @paragraphes = @ressource.content.scan(/^(.*)(\.|\!|\?)?$/).map(&:first)
    @list_of_voters = @ressource.votes_for.voters
  end

  def new
    @ressource = Ressource.new
    @categories = ["Chercher un job", "Changer de métier", "Changer de boite", "Créer sa boite", "Intraprendre"]
    @subcategories = ["S'inspirer", "S'informer", "Se Faire Aider", "Se Former", "Réseauter", "Postuler", "S'éclater"]
  end

  def create
    @ressource = Ressource.new(ressource_params)

    if @ressource.save
      @ressource.update(user_id: current_user.id)
      # @ressource.update(ressource_id: @ressource.id)
      redirect_to ressource_path(@ressource)
      # vérifier le chemin pour l'id
    else
      render :new
    end
  end

  def edit
  end

  def update
    @ressource.update(ressource_params)
    redirect_to ressource_path(@ressource)
  end

  def destroy
    @ressource.destroy
    redirect_to ressources_path
  end

  def like
    @ressource = Ressource.friendly.find(params[:id])
    @ressource.liked_by current_user
    # ajouter de l'ajax pour rafraichissement page instantané
    # respond_to do |format|
    #   format.html { redirect_to ressources_path }
    #   format.js
    # end
    redirect_to ressources_path
  end

  def dislike
    @ressource = Ressource.friendly.find(params[:id])
    @ressource.disliked_by current_user
    redirect_to ressources_path
  end

  def category
    @categories = ["Chercher un job", "Changer de métier", "Changer de boite", "Créer sa boite", "Intraprendre"]
    @subcategories = ["S'inspirer", "S'informer", "Se Faire Aider", "Se Former", "Réseauter", "Postuler", "S'éclater"]
    @subcat_sidebar = ["Voir tout"]
    # @ressources = Ressource.all.order('created_at DESC')
    @category_page = params[:category]
    @ressources = Ressource.where(category: @category_page)
  end

  private

  def ressource_params
    params.require(:ressource).permit(:title, :description, :content, :witness, :website, :address, :category, :subcategory, :picture, :logo, :seotitle, :seodescription)
  end

  def set_ressource
    @ressource = Ressource.friendly.find(params[:id])
  end

end