class BooksController < ApplicationController

  before_action :correct_user, only: [:edit,:update,:destroy]

  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "YOU have created book successfully"
    redirect_to book_path(@book.id)
    else
    @user=User.find(current_user.id)
    @books=Book.all
    render :index
    end
  end

  def index
    @books=Book.all
    @user=User.find(current_user.id)
    @book=Book.new
  end

  def show
    @book=Book.find(params[:id])
    @user=@book.user
    @books=Book.new
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:update]="You have updated book successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

private

 def book_params
   params.require(:book).permit(:title,:body)
 end

 def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
 end

end
