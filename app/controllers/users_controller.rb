class UsersController < ApplicationController
  before_action :authorized?

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.user_type = params[:user_type]
    @user.save
    redirect_to action: :show
  end

  protected
  def authorized?
    authorize! :manage, User
  end
end
