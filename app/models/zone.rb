class Zone
  include Mongoid::Document
  has_many :shopping_availabilities
  has_many :shopping_times
  field :label, type: String
  field :name, type: String
  field :description, type: String

  # this will need to get smarter as we grow...
  def self.defaults
    {
      'San Francisco' => [
        {name: 'SoMa', description: 'South of Market St, North of Deboce/13th/Division and Mission Creek'},
        {name: 'Northeast', description: 'North of Market, East of Van Ness: FiDi, Chinatown, North Beach, Russian Hill, Civic Center, Tenderloin'},
        {name: 'Marina / Pac Heights', description: 'Marina, Pac Heights'},
        {name: 'Mission / Portrero', description: 'Mission, Portrero, Dogpatch'},
        {name: 'Noe / Castro', description: 'Castro, Noe Valley, Bernal Heights, Glen Park'},
        {name: 'North Central', description: 'Cole Valley, Haight Ashbuy, Lower Haight, Anza Vista, Western Addition, Alamo Square (All South of Geary)'},
        {name: 'Central', description: 'Twin Peaks, Diamond Heights, Forest Hill, West Portal'},
        {name: 'Southwest', description: 'Lake Merced, SFSU, Westwood Highlands, Westwood Park (All West of 280)'},
        {name: 'Southeast', description: 'Bayview, Vistacon Valley, Excelsior, Crocker-Amazon'},
        {name: 'Richmond', description: 'Richmond, Presido, Seacliff'},
        {name: 'Sunset', description: ''},
        {name: 'Treasure Island', description: ''},
      ],
      'Peninsula' => [
        {name: 'Daly City', description: 'Including Broadmoor'},
        {name: 'South SF', description: ''},
        {name: 'San Bruno', description: ''},
        {name: 'Millbrae', description: ''},
        {name: 'Burlingame', description: ''},
      ],
      'East Bay' =>[
        {name: 'North Oakland', description: 'Hills + Montclair, Claremont, Rockridge, Temescal, Emeryville, Piedmont'},
        {name: 'Downtown Oakland', description: 'West Oakland, Downtown, Lake Merritt, Grand Lake'},
        {name: 'East Oakland', description: 'Anything Southeast of Fruitvale Ave or Lincoln Ave'},
        {name: 'Berkeley / Albany', description: ''},
        {name: 'Alameda', description: ''},
      ]
    }
  end

  def self.generate
    self.defaults.each do |label, zones|
      zones.each do |zone|
        Zone.create(zone.merge(label: label))
      end
    end
  end

  # cache this bad boy
  def self.grouped_options
    Rails.cache.fetch('zone-grouped-options') do
      ret = {}
      self.defaults.keys.each do |label|
        ret[label] = Zone.where(label: label).map {|zone| zone.name}
      end
      ret
    end
  end

end
