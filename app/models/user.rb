class User
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  has_many :lists
  has_one :customer_profile

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
    %w(User Admin Shopper Customer)
  end

  def phone_stripped
    stripped = self.phone.gsub(/[^\d]/,'')
    if stripped.length == 10
      stripped = "1" + stripped
    end
    stripped
  end

  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    self._type == 'Admin'
  end
end
