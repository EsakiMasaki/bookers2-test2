class UsersController < ApplicationController
  before_action :user_matching?, only: [:edit,:update]
  
  def index
    @users = User.all
    @user = User.find_by(id: current_user.id)
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
  
  def user_matching?
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user)
    end
  end
end
