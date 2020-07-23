class BooksController < ApplicationController
  before_action :authenticate_user!



  def index
  	@books = Book.all
  	@book = Book.new
    @user = current_user
    @users = User.all

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user

  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end

  end


  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
  	redirect_to book_path(@book.id)
  else
    render 'index'
  end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  private
    def book_params
   	   params.require(:book).permit(:title,:body)
   	end
end
