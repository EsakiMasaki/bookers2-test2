class BooksController < ApplicationController
  before_action :book_matching?, only: [:edit,:update,:destroy]
  
  def index
    @user = User.find_by(id: current_user.id)
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @books = Book.all
    @user = User.find_by(id: current_user.id)
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def show
    @book_id = Book.find(params[:id])
    @user = User.find_by(id: @book_id.user.id)
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  def book_params
    params.require(:book).permit(:title,:body)
  end
  
  def book_matching?
    book = Book.find(params[:id])
    if current_user.id != book.user.id
      redirect_to books_path
    end
  end
end
