class ShoppingTrip
  include Mongoid::Document
  belongs_to :customer
  belongs_to :buyer
  field :day, type: :string
  field :time, type: :string

  class << self
    def days
      Date::DAYNAMES.map {|d| d.downcase}
    end

    def times
      %w(morning afternoon evening night)
    end
  end

end
