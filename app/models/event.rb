class Event < ApplicationRecord
    attr_accessor :venue_name
    has_many :users, :through => :saved_events
    belongs_to :venue

    class << self
    
        def available_event_types
            ['trivia', 'live music', 'dancing', 'sports']
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

    scope :with_event_type, -> (types) { 
      where(event_type: types)
    }

    scope :with_attire, -> (attires) { 
        where(attire: attires)
      }

    scope :search, -> (query) {
        where("name like ?", "%#{query}%")
    }

    scope :saved_by, -> (users) {
        saved_events = SavedEvent.where(user_id: users)
        where(id: saved_events.map {|event| event.event_id})
    }

end