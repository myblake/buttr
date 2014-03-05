class List
  include Mongoid::Document
  belongs_to :user
  has_many :list_items

  field :shopping_date, type: Time

  def list_items_by_category
    ret = {}
    self.list_items.all.each do |list_item|
      ret[list_item.category.name] = ret[list_item.category.name].nil? ? [list_item] : ret[list_item.category.name] << list_item
    end
    ret
  end

end
