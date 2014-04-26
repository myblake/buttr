class ShoppingAvailability
  include Mongoid::Document
  belongs_to :shopper
  belongs_to :zone
  field :day, type: String
  field :time, type: String

  # TODO: add geo and maybe list of stores

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
