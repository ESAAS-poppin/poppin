class Venue < ApplicationRecord
    has_many :events

    class << self
    
        def available_venue_types
            ['bar', 'club']
        end
        def available_price_ranges
            ['$', '$$', '$$$']
        end
        def available_attires
            ['buisness casual', 'black tie', 'casual', 'fancy', 'cowboy']
        end
        
    end


    scope :with_price_range, -> (range) { 
      where(price_range: range)
    }

    scope :with_venue_type, -> (types) { 
      where(venue_type: types)
    }

    scope :with_attire, -> (attires) { 
        where(attire: attires)
    }

    scope :search, -> (query) {
        where("name like ?", "%#{query}%")
    }
end
