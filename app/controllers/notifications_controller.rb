class NotificationsController < ApplicationController
  before_filter :set_user
  def customer_dropoff
  end

  def customer_shopping
  end

  def buyer_shopping
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end