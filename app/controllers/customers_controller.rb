class CustomersController < UsersController
  before_action :set_customer, only: [:show, :wallet, :update_wallet, :edit, :update]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def show
  end

  def wallet
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
    @customer.buyer = Buyer.find(params[:customer][:buyer_id])
    @customer.save
    redirect_to action: :index
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :buyer_id, :email, :phone, :wunderlist_url, :feedback_url, shopping_time_attributes: [:day, :time])
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
