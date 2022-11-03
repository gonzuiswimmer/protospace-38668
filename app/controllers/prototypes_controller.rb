class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new, :destroy]
  
  def index
    @prototype = Prototype.all
  end

  def create
    @prototype = Prototype.new(proto_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new 
    end
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @comment = Comment.new
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(proto_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def proto_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :user, :image).merge(user_id: current_user.id)
    # params.require(:モデル名).permit(:キー名, :キー名) # 取得したいキーを指定する
  end

end
