class ShoppingTime
  include Mongoid::Document
  belongs_to :customer
  belongs_to :shopper
  field :day, type: String
  field :time, type: String

  class << self
    def days
      Date::DAYNAMES
    end

    def times
      %w(morning afternoon evening night)
    end
  end

end
