class CommentsController < ApplicationController
  before_filter :check_privileges!, only: [:destroy]
  before_action :find_ressource, only: [:create, :destroy]

  def index
    @ressource = Ressource.find(params[:ressource_id])
    @comments = @ressource.comments
  end

  def create
    @comment = @ressource.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      @comment.update(user_id: current_user.id)
      redirect_to ressource_path(@ressource)
      puts "Merci pour votre témoignage / commentaire :)"
      # respond_to do |format|
      #   format.html { redirect_to ressource_path(@ressource) }
      #   format.js
      # end
    else
      # respond_to do |format|
      #   format.html { render 'ressource/show' }
      #   format.js
      # end
      puts "Désolé, il y a eu un problème :("
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to ressource_path(:ressource_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end

  def find_ressource
    @ressource = Ressource.friendly.find(params[:ressource_id])
  end
end
