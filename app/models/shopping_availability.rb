class ShoppingAvailability
  include Mongoid::Document
  belongs_to :shopper
  field :day, type: String
  field :time, type: String

  validates_uniqueness_of :shopper_id, scope: [:day, :time]

  class << self
    def days
      Date::DAYNAMES
    end

    def times
      %w(morning afternoon evening night)
    end
  end
end
