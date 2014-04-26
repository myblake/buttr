class CustomersController < UsersController
  before_action :set_customer, only: [:show, :wallet, :update_wallet, :edit, :update]
  skip_before_filter :authorized?, only: :wallet

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def show
  end

  def wallet
    authorize! :read, current_user
    @customer.create_wallet if @customer.wallet.nil?
  end

  def update_wallet
    amount = params[:transaction][:amount].to_f
    wallet = @customer.wallet || @customer.create_wallet
    if params[:transaction][:transaction_type] == 'credit'
      wallet.credit(amount, params[:transaction][:note])
    elsif params[:transaction][:transaction_type] == 'debit'
      wallet.debit(amount, params[:transaction][:note])
    end
    wallet.save
    redirect_to action: 'wallet'
  end

  def edit
  end

  def update
    @customer.create_shopping_time(customer_params[:shopping_time_attributes]) unless @customer.shopping_time
    @customer.update_attributes(customer_params)
    redirect_to action: :show
  end

  def create
    @customer = Customer.create(customer_params.merge(password: Devise.friendly_token.first(8)))

    unless @customer.valid?
      flash[:error] = ("Customer could not be created because: " + format_errors(@customer.errors.full_messages)).html_safe
    else
      @customer.shopper = Shopper.find(params[:customer][:shopper_id])
      @customer.save
    end
    redirect_to action: :index
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :shopper_id, :email, :phone, :wunderlist_url, :feedback_url, shopping_time_attributes: [:id, :shopper_id, :day, :time])
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
