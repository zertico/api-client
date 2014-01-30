# It will works with respond_with.
# Your action should looks like any other one: A model with a method call. =D
class BookController < ApplicationController
  # It will hit http://api.example.com/books with a get request
  def index
    @books = Book.all
    respond_with(@books)
  end

  # It will initialize a new object based on the attribute accessors
  def new
    @book = Book.new
    respond_with(@book)
  end

  # It will hit http://api.example.com/books with a post request
  def create
    @book = Book.create(:book => params[:book])
    respond_with(@user)
  end

  # It will hit http://api.example.com/books/1 with a get request
  def edit
    @book = Book.find(params[:id])
    respond_with(@book)
  end

  # It will hit http://api.example.com/books with a put request
  def update
    @book = Book.update_attributes(params[:id], { :book => params[:book] })
    respond_with(@book)
  end

  # It will hit http://api.example.com/books/1 with a get request
  def show
    @book = Book.find(params[:id])
    respond_with(@book)
  end

  # It will hit http://api.example.com/books/1 with a delete request
  def delete
    @book = Book.destroy(params[:id])
    respond_with(@book)
  end
end