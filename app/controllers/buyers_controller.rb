class BuyersController < ApplicationController
  def index
    @buyers = User.buyer_list
  end
  
  def new
    @buyer = User.new
  end

  def show
    @buyer = User.find(params[:id])
  end
  
  def create
    User.create(params[:user].permit([:first_name, :last_name, :email, :phone]).merge(user_type: 'buyer', password: Devise.friendly_token.first(8)))
    redirect_to action: :index
  end
end
