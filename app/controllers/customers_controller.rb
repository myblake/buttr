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

  def edit
    @customer = User.find(params[:id])
  end

  def update
    @customer = User.find(params[:id])
    @customer.update_attributes(params[:user].permit(permitted_fields))
    redirect_to action: :show
  end
  
  def create
    @customer = User.create(params[:user].permit(permitted_fields).merge(user_type: 'customer', password: Devise.friendly_token.first(8)))
    @customer.buyer = User.find(params[:user][:buyer_id])
    @customer.save
    redirect_to action: :index
  end

  private
  def permitted_fields
    [:first_name, :last_name, :email, :phone, :wunderlist_url, :feedback_url]
  end
end
