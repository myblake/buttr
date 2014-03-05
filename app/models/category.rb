class Category
  include Mongoid::Document
  has_many :list_items

  field :name, type: String
end
