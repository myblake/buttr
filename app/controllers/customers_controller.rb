class CustomersController < ApplicationController
  def index
    @customers = User.where(user_type: 'customer')
  end

  def new
    @customer = User.new
  end

  def show
    @customer = User.find(params[:id])
  end
  
  def create
    @customer = User.create(params[:user].permit([:first_name, :last_name, :email, :phone]).merge(user_type: 'customer', password: Devise.friendly_token.first(8)))
    debugger
    @customer.buyer = User.find(params[:user][:buyer_id])
    @customer.save
    redirect_to action: :index
  end
end
