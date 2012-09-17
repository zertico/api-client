class UserController < ApplicationController
  # It will works with respond_with.
  # Your action should looks like any other one: A model with a method call. =D
  def index
    @users = User.get("api.example.com/users")
    respond_with(@users)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.post("api.example.com/users", :user => params[:user])
    respond_with(@user)
  end

  def edit
    @user = User.get("api.example.com/users/#{params[:id]}")
    respond_with(@user)
  end

  def update
    @user = User.patch("api.example.com/users", { :id => params[:id], :user => params[:user]})
    respond_with(@user)
  end

  def show
    @user = User.get("api.example.com/users/#{params[:id]}")
    respond_with(@user)
  end
end
