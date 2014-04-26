class ShoppingTrip
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  belongs_to :customer
  belongs_to :shopper

  # maybe should be embedded?
  belongs_to :shopping_time

  field :time, type: DateTime

end
