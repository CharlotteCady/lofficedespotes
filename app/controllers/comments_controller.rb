class CommentsController < ApplicationController

  def index
    @ressource = Ressource.find(params[:ressource_id])
    @comments = @ressource.comments
  end

  def create
    @ressource = Ressource.find(params[:ressource_id])
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

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
