class Shopper < User
  has_many :customers
  has_many :shopping_times
  has_many :shopping_trips

  def self.shopper_list_for_select
    Shopper.all.map{|shopper| ["#{shopper.first_name} #{shopper.last_name}", shopper.id]}
  end
end
