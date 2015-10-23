class CommentsController < ApplicationController
  before_filter :check_privileges!, only: [:destroy]
  before_action :find_ressource, only: [:create, :destroy]
  # respond_to :html, :js

  def index
    @ressource = Ressource.find(params[:ressource_id])
    @comments = @ressource.comments
  end

  def create
    @comment = @ressource.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      # @comment.update(user_id: current_user.id)
      # puts "Merci pour votre témoignage / commentaire :)"
      # redirect_to ressource_path(@ressource)
      respond_to do |format|
        format.html { redirect_to ressource_path(@ressource) }
        format.js # <-- will render `app/views/comments/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'ressources/show' }
        format.js
      end
      # puts "Désolé, il y a eu un problème :("
    end
  end

  # def edit
  #   @comment = @ressource.comments.find(params[:id])
  # end

  # def update
  #   @comment = @ressource.comments.find(params[:id])
  #   @ressource.comments.update(comment_params)
  #   redirect_to ressource_path(@ressource)
  # end

  def destroy
    @comment = @ressource.comments.find(params[:id])
    @comment.delete
    redirect_to ressource_path(@ressource)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

  def find_ressource
    @ressource = Ressource.friendly.find(params[:ressource_id])
  end
end
