class Customer < User
  belongs_to :shopper
  has_one :shopping_time
  has_one :customer_profile
  
  accepts_nested_attributes_for :shopping_time

  # TODO: add geography
  has_many :shopping_trips
  embeds_one :wallet
end
