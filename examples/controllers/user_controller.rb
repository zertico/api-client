class UserController < ApplicationController
  # It will works with respond_with.
  # Your action should looks like any other one: A model with a method call. =D
  def index
    @users = User.collection("#{ApiClient.config.path}users")
    respond_with(@users)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.post("#{ApiClient.config.path}users", :user => params[:user])
    respond_with(@user)
  end

  def edit
    @user = User.get("#{ApiClient.config.path}users/#{params[:id]}")
    respond_with(@user)
  end

  def update
    @user = User.patch("#{ApiClient.config.path}users", { :id => params[:id], :user => params[:user]})
    respond_with(@user)
  end

  def show
    @user = User.get("#{ApiClient.config.path}users/#{params[:id]}")
    respond_with(@user)
  end

  def delete
    @user = User.delete("#{ApiClient.config.path}users/#{params[:id]}")
    respond_with(@user)
  end
end
