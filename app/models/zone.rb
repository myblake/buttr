class Zone
  include Mongoid::Document
  has_many :shopping_availabilities
  has_many :shopping_times
  field :name, type: String
  field :description, type: String

  # this will need to get smarter as we grow...
  def self.defaults
    [
        {name: 'SoMa', description: 'South of Market St, North of Deboce/13th/Division and Mission Creek'},
        {name: 'Mission', description: ''},
        {name: 'Portrero / Dogpatch', description: ''},
        {name: 'Mission', description: ''},
    ]
  end
end
