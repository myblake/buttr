class User
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  has_many :lists

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

  #validates_inclusion_of :user_type, in: User.user_types

  # validates_uniqueness_of :email won't work when we directly create from the user subclasses
  validate :validate_unique_email

  def validate_unique_email
    existing_user = User.where(email: self.email).first
    if existing_user && existing_user.id != self.id && existing_user.user_type != self.user_type
      errors.add(:email, "is already taken")
    end
  end

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

  def user_type=(type)
    self.write_attribute('_type', type)
  end

  def user_type
    self.read_attribute('_type')
  end

  def name
    "#{first_name} #{last_name}"
  end

  # better than method missing (faster) for this case since it's well defined
  self.user_types.each do |type|
    method = "is_#{type.downcase}?"
    define_method(method) { user_type == type }
  end
end
