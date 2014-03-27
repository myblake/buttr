class CustomersController < UsersController
  before_action :set_customer, only: [:show, :wallet, :update_wallet, :edit, :update]

  def index
    @customers = User.where(user_type: 'customer')
  end

  def new
    @customer = User.new
  end

  def show
    if @customer.user_type != 'customer'
      flash[:alert] = "User is not a customer"
      redirect_to "/"
    end
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

  def set_customer
    @customer = User.find(params[:id])
  end
end