class Shopper < User
  has_many :customers
  has_many :shopping_times
  has_many :shopping_availabilities
  has_many :shopping_trips

  field :profile_url, type: String

  def self.shopper_list_for_select
    Shopper.all.map{|shopper| ["#{shopper.first_name} #{shopper.last_name}", shopper.id]}
  end

  class << self
    def master_calendar
      master_calendar = {}
      Shopper.all.each do |shopper|
        shopper_cal = shopper.calendar
        shopper_cal.each do |day, times|
          master_calendar[day] = {} if master_calendar[day].nil?
          times.each do |time, customers|
            master_calendar[day][time] = [] if master_calendar[day][time].nil?
            master_calendar[day][time] += customers
          end
        end
      end
      master_calendar
    end

    def master_availability
      master_availability = {}
      Shopper.all.each do |shopper|
        shopper_avail = shopper.availability
        shopper_avail.each do |day, times|
          master_availability[day] = {} if master_availability[day].nil?
          times.each do |time, customers|
            master_availability[day][time] = [] if master_availability[day][time].nil?
            master_availability[day][time] += [shopper]
          end
        end
      end
      master_availability
    end
  end

  def calendar
    days_hash = {}
    shopping_times.each do |st|
      days_hash[st.day] = {} if days_hash[st.day].nil?
      days_hash[st.day][st.time] = days_hash[st.day][st.time].nil? ? [st] : days_hash[st.day][st.time] + [st]
    end
    days_hash
  end

  def availability
    days_hash = {}
    shopping_availabilities.each do |st|
      days_hash[st.day] = {} if days_hash[st.day].nil?
      days_hash[st.day][st.time] = st
    end
    days_hash
  end

  def update_availability(options)
    day = options[:day]
    time = options[:time]
    zone = options[:zone]
    level = options[:level]
    
    # for some reason find is not returning anything :/
    if availability = shopping_availabilities.find_all{|a| a.day == day && a.time == time}.first
      availability.level = level
      availability.zone = Zone.where(name: zone).first
      availability.save
      return {action: 'update', object: availability}
    else
      availability = shopping_availabilities.create(day: day, time: time, level: level, zone: zone)
      return {action: 'create', object: availability}
    end
  end
end
