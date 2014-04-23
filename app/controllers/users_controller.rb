class UsersController < ApplicationController
  def new
    @user = User.all.find(params[:id])
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end
end
