class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
    @prototype = Prototype.find(params[:prototype_id])
    if @comment.save
      redirect_to prototype_path(@prototype.id)
    else
      @prototype = @comment.prototype
      # @comments = @prototype.comments
      render "prototypes/show"
      # ↑実装できてるけど、理解がまだ
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(prototype_id: params[:prototype_id], user_id: current_user.id)
  end
end
