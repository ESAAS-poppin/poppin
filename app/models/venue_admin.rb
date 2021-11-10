class VenueAdmin < ApplicationRecord
    has_one :venue
    has_many :events, :through => :venue

    class << self
    
        def available_venue_types
            ['bar', 'club']
        end
        def available_price_ranges
            ['$', '$$', '$$$']
        end
        def available_attires
            ['business_casual', 'black tie', 'casual', 'fancy', 'cowboy']
        end
        
    end
end
