class User
  include Mongoid::Document

  has_many :lists
  has_one :customer_profile

  has_many :customers, class_name: "User"
  belongs_to :buyer, class_name: "User"
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :first_name, type: String
  field :last_name, type: String
  field :user_type, type: String
  field :phone, type: String
  field :wunderlist_url, type: String
  field :feedback_url, type: String

  validates_uniqueness_of :email
  #validates_inclusion_of :user_type, in: User.user_types
  
  def self.user_types
    %w(admin bttr buyer customer)
  end

  def phone_stripped
    stripped = self.phone.gsub(/[^\d]/,'')
    if stripped.length == 10
      stripped = "1" + stripped
    end
    stripped
  end

  def self.buyer_list
    User.where(user_type: 'buyer')
  end

  def name
    "#{first_name} #{last_name}"
  end

  def self.buyer_list_for_select
    buyer_list.map{|buyer| ["#{buyer.first_name} #{buyer.last_name}", buyer.id]}
  end
  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time
  def display_name
    "#{self.first_name} #{self.last_name}"
  end
end
