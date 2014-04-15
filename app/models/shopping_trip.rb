class ShoppingTrip
  include Mongoid::Document
  belongs_to :customer
  belongs_to :shopper
  belongs_to :shopping_time
  field :time, type: DateTime

end
