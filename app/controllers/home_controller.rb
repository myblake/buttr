class HomeController < ApplicationController
  def index
    if route_user
      return
    end
  end

  def admin
  end

  private
  def route_user
    if current_user.is_admin?
      redirect_to controller: :home, action: :admin
    elsif current_user.is_shopper?
      redirect_to controller: :shoppers, action: :show, id: current_user.id
    elsif current_user.is_customer?
      redirect_to controller: :customers, action: :wallet, id: current_user.id
    end
    return true
  end
end
