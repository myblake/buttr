class UsersController < ApplicationController
  include ApplicationHelper
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
    if params[:password] && !@user.is_admin?
      @user.password = params[:password]
    end
    @user.save
    redirect_to action: :index
  end

  def spoof_user
    # check for admin
    authorize! :spoof, User
    @user_to_spoof = User.find(params[:new_user_id])
    sign_in(@user_to_spoof)
    redirect_to '/'
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
