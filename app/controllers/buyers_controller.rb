class BuyersController < UsersController
  def index
    @buyers = Buyer.all
  end

  def new
    @buyer = Buyer.new
  end

  def show
    @buyer = Buyer.find(params[:id])
  end

  def create
    Buyer.create(params[:buyer].permit([:first_name, :last_name, :email, :phone]).merge(password: Devise.friendly_token.first(8)))
    redirect_to action: :index
  end
end
