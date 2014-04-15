class Buyer < User
  has_many :customers
  has_many :shopping_times
  has_many :shopping_trips

  def self.buyer_list_for_select
    Buyer.all.map{|buyer| ["#{buyer.first_name} #{buyer.last_name}", buyer.id]}
  end
end
