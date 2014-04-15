class Shopper < User
  has_many :customers
  has_many :shopping_times
  has_many :shopping_trips

  field :profile_url, type: String

  def self.shopper_list_for_select
    Shopper.all.map{|shopper| ["#{shopper.first_name} #{shopper.last_name}", shopper.id]}
  end

  def calendar
    days_hash = {}
    shopping_times.each do |st|
      days_hash[st.day] = {} if days_hash[st.day].nil?
      days_hash[st.day][st.time] = days_hash[st.day][st.time].nil? ? [st] : days_hash[st.day][st.time] + [st]
    end
    days_hash
  end
end
