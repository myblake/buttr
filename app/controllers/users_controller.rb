class UsersController < ApplicationController
  before_action :read_user?

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attribute('_type', params[:_type])
    if params[:password]
      @user.password = params[:password]
    end
    @user.save
    redirect_to action: :index
  end

  protected
  def set_user
    @user = User.find(params[:id])
  end

  def read_user?
    if params[:id]
      set_user
    end
    authorize! :read, @user.nil? ? User : @user
  end
end
