class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_filter :check_privileges!, only: [:new, :create, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:index, :show, :category]

  CATEGORIES = ["Top", "Astuces", "Témoignages"]

  def index
    @categories = CATEGORIES
    @articles = Article.all.order('created_at DESC')
  end

  def new
    @article = Article.new
    @categories = CATEGORIES
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      @article.update(user_id: current_user.id)
        redirect_to article_path(@article)
      # vérifier le chemin pour l'id
    else
      render :new
    end
  end

  def show
    @categories = CATEGORIES
    @mois = %w( Janvier Février Mars Avril Mai Juin Juillet Août Septembre Octobre Novembre Décembre )
    @category_list = eval(@article.category) - [""]
  end

  def edit
    @categories = CATEGORIES
  end

  def update
    @article.update(article_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def category
    @categories = CATEGORIES
    @category = params[:category]

    if @category
      @articles = Article.search_article(@category).order('created_at DESC')
    else
      @articles = Article.all.order('created_at DESC')
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :seo_title, :seo_description, :picture, :category => [])
  end

  def set_article
    @article = Article.friendly.find(params[:id])
  end
end
