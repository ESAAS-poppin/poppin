class Venue < ApplicationRecord
    has_many :events
    belongs_to :venue_admin, optional: true

    class << self
    
        def available_venue_types
            ['bar', 'club']
        end
        def available_price_ranges
            ['$', '$$', '$$$']
        end
        def available_attires
            ['business casual', 'black tie', 'casual', 'fancy', 'cowboy']
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

    scope :saved_by, -> (users) {
        saved_venues = SavedVenue.where(user_id: users)
        where(id: saved_venues.map {|venue| venue.venue_id})
    }
end
