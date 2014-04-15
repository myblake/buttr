class ShoppersController < UsersController
  before_action :set_shopper, only: [:show, :edit, :update]

  def index
    @shoppers = Shopper.all
  end

  def new
    @shopper = Shopper.new
  end

  def edit
  end

  def update
    @shopper.update_attributes(shopper_params)
    redirect_to action: :show
  end

  def show
  end

  def create
    Shopper.create(shopper_params.merge(password: Devise.friendly_token.first(8)))
    redirect_to action: :index
  end

  private
  def shopper_params
    params.require(:shopper).permit(:first_name, :last_name, :email, :phone, :profile_url)
  end
  def set_shopper
    @shopper = Shopper.find(params[:id])
  end
end