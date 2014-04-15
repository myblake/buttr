class ShoppersController < UsersController
  def index
    @shoppers = Shopper.all
  end

  def new
    @shopper = Shopper.new
  end

  def show
    @shopper = Shopper.find(params[:id])
  end

  def create
    Shopper.create(params[:shopper].permit([:first_name, :last_name, :email, :phone]).merge(password: Devise.friendly_token.first(8)))
    redirect_to action: :index
  end
end
