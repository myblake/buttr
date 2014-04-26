class ShoppersController < UsersController
  before_action :set_shopper, only: [:show, :edit, :update, :toggle_availability]

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

  def master_calendar
    authorize! :read, :calendar
  end

  def create
    shopper = Shopper.create(shopper_params.merge(password: Devise.friendly_token.first(8)))
    #debugger
    unless shopper.valid?
      flash[:error] = ("Shopper could not be created because: " + format_errors(shopper.errors.full_messages)).html_safe
    end
    redirect_to action: :index
  end

  def toggle_availability
    day = params[:day]
    time = params[:time]
    status = @shopper.toggle_availability(day, time)
    render json: status
  end

  private
  def shopper_params
    params.require(:shopper).permit(:first_name, :last_name, :email, :phone, :profile_url)
  end
  def set_shopper
    @shopper = Shopper.find(params[:id])
  end
end
