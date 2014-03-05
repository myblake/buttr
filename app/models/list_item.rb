class ListItem
  include Mongoid::Document
  belongs_to :list
  belongs_to :category

  field :description, type: String
  field :active, type: Boolean
end
