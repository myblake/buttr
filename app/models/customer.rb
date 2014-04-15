class Customer < User
  belongs_to :buyer
  has_one :shopping_trip
  accepts_nested_attributes_for :shopping_trip
  embeds_one :wallet
end
