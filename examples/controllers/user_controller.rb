# It will works with respond_with.
# Your action should looks like any other one: A model with a method call. =D
class UserController < ApplicationController
  # It will hit http://api.example.com/users with a get request
  def index
    @users = User.collection
    respond_with(@users)
  end

  # It will initialize a new object based on the attribute accessors
  def new
    @user = User.new
    respond_with(@user)
  end

  # It will hit http://api.example.com/users with a post request
  def create
    @user = User.post(params[:user])
    respond_with(@user)
  end

  # It will hit http://api.example.com/users/1 with a get request
  def edit
    @user = User.get(params[:id])
    respond_with(@user)
  end

  # It will hit http://api.example.com/users with a patch request
  def update
    @user = User.patch(params[:id], params[:user])
    respond_with(@user)
  end

  # It will hit http://api.example.com/users/1 with a get request
  def show
    @user = User.get(params[:id])
    respond_with(@user)
  end

  # It will hit http://api.example.com/users/1 with a delete request
  def delete
    @user = User.delete(params[:id])
    respond_with(@user)
  end
end