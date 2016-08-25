class RessourcesController < ApplicationController
  before_action :set_ressource, only: [:show, :edit, :update, :destroy]
  before_filter :check_privileges!, only: [:new, :create, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:index, :show, :category]

  CATEGORIES = ["Trouver sa voie", "Trouver un job", "Changer de métier", "Changer de boite", "Créer sa boite", "Coup de Coeur"]
  SUBCATEGORIES = ["S'inspirer", "S'informer", "Se Faire Aider", "Se Former", "Réseauter", "Postuler", "Profiter"]
  SECTOR_LIST = ["Tout", "Communication", "Artisanat", "Web", "Design", "Santé", "Education", "Aide" , "Service", "Bâtiment", "Agro-alimentaire", "Restauration"]
  CITY = ["France", "Paris", "Nantes", "Bordeaux", "Strasbourg", "Marseille", "Lyon", "Toulouse", "Tours",
           "Lille", "Rennes", "Brest", "Nice", "Aix en Provence", "Caen"]
  SUBCAT_SIDEBAR = ["Voir tout"]
  TAGS = ["Apprendre à mieux se connaître", "Faire un joli CV", "Postuler sur un job board", "Se faire Accompagner", "Découvrir des métiers", "Faire des rencontres pro", "Découvrir des histoires inspirantes", "Se former autrement", "Se faire recommander", "Se changer les idées", "Optimiser sa recherche"]
  PROFIL = ["Étudiant", "Jeune diplômé", "Senior", "En recherche d'emploi", "En poste", "En reconversion / Ré-orientation", "Entrepreneur / Freelance / Indépendant"]
  PRICE = ["Gratuit", "Payant", "Promo"]

  def index
    category = params[:category]
    subcategory = params[:subcategory]
    keyword = params[:search]
    profil = params[:profil]
    tag = params[:tag]
    # if (keyword != "") || (subcategory != "") || (profil != "")
    if keyword || subcategory || profil
      if Ressource.search_index(keyword, subcategory, profil) == nil
        @ressources = Ressource.all.order('created_at DESC')
      else
        @ressources = Ressource.search_index(keyword, subcategory, profil).order('created_at DESC')
      end
    elsif category
      @ressources = Ressource.search_by_category(category).order('created_at DESC')
    elsif tag
      @ressources = Ressource.search_by_tag(tag).order('created_at DESC')
    else
      @ressources = Ressource.all.order('created_at DESC')
    end
    @categories = CATEGORIES
    @subcategories = SUBCATEGORIES
    @subcat_sidebar = SUBCAT_SIDEBAR
    @profil = PROFIL
    @tags = TAGS
    current_host
  end

  # def search
  #   @key_word = params[:search][:query]
  #   @ressources = Ressource.where("title ILIKE ? or content ILIKE ?", @key_word, @key_word)
  # end

  def show
    @categories = CATEGORIES
    @subcategories = SUBCATEGORIES
    @subcat_sidebar = SUBCAT_SIDEBAR
    @comment = @ressource.comments.new
    @comments = Comment.where(commentable_id: @ressource)
    @mois = %w( Janvier Février Mars Avril Mai Juin Juillet Août Septembre Octobre Novembre Décembre )
    @paragraphes = @ressource.content.scan(/^(.*)(\.|\!|\?)?$/).map(&:first)
    @list_of_voters = @ressource.votes_for.voters
    @category_list = eval(@ressource.category) - [""]
    # @tag_list = eval(@ressource.tag) - [""]
  end

  def new
    @ressource = Ressource.new
    @categories = CATEGORIES
    @subcategories = SUBCATEGORIES
    @sector_list = SECTOR_LIST
    @city = CITY
    @tags = TAGS
    @profil = PROFIL
    @price = PRICE
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
    @categories = CATEGORIES
    @subcategories = SUBCATEGORIES
    @sector_list = SECTOR_LIST
    @city = CITY
    @tags = TAGS
    @profil = PROFIL
    @price = PRICE
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
    respond_to do |format|
      format.html { redirect_to ressources_path }
      format.js { render layout: false }
    end
    # redirect_to ressources_path
  end

  def dislike
    @ressource = Ressource.friendly.find(params[:id])
    @ressource.disliked_by current_user
    # redirect_to ressources_path
    respond_to do |format|
      format.html { redirect_to ressources_path }
      format.js { render layout: false }
    end
  end

  def category
    @categories = CATEGORIES
    @subcategories = SUBCATEGORIES
    @subcat_sidebar = SUBCAT_SIDEBAR
    @profil = PROFIL
    @tags = TAGS
    @category_page = params[:category]
    # @ressources = Ressource.where(category: @category_page)
    # ====== Barre de recherche
    category = @category_page
    subcategory = params[:subcategory]
    profil = params[:profil]
    keyword = params[:search]
    if category || subcategory || profil || keyword
      @ressources = Ressource.search(category, subcategory, profil, keyword).order('created_at DESC')
    else
      @ressources = Ressource.where(category: @category_page).order('created_at DESC')
    end
    current_host
  end

  def current_host
    if request.host == "localhost"
      @url_host = "http://localhost:3000"
    elsif request.host == "lofficedespotes-staging.herokuapp.com"
      @url_host = "http://lofficedespotes-staging.herokuapp.com"
    else
      @url_host = "http://lofficedespotes.herokuapp.com"
    end
  end

  private

  def ressource_params
    params.require(:ressource).permit(:title, :description, :content, :picturecontent1, :content2, :picturecontent2, :content3,
     :witness, :website, :address, :subcategory, :picture, :logo, :seotitle, :seodescription, :bootsy_image_gallery_id, :price, :offer,
     :category => [], :sector => [], :city => [], :tag => [], :profil => [])
  end

  def set_ressource
    @ressource = Ressource.friendly.find(params[:id])
  end

end
