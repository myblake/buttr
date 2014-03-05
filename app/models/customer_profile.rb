class CustomerProfile
  include Mongoid::Document
  belongs_to :user
end
