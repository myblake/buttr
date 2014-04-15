class Customer < User
  belongs_to :shopper
  has_one :shopping_time
  accepts_nested_attributes_for :shopping_time

  has_many :shopping_trips
  embeds_one :wallet
end
