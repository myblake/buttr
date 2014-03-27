class NotificationsController < ApplicationController
  # load_and_authorize_resource
  before_filter :set_user
  before_filter :authorized?
  def customer_dropoff
  end

  def customer_shopping
  end

  def buyer_shopping
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def authorized?
    authorize! :show, @user
  end
end