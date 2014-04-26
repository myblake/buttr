class CustomerProfile
  include Mongoid::Document
  belongs_to :customer
end
