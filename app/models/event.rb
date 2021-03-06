class Event < ApplicationRecord
    attr_accessor :event
    attr_accessor :venue_name
    has_many :users, :through => :saved_events
    has_one_attached :event_image
    belongs_to :venue

    class << self
    
        def available_event_types
            ['trivia', 'live music', 'dancing', 'sports', 'cheap drinks', 'party', 'brunch']
        end
        def available_price_ranges
            ['$', '$$', '$$$']
        end
        def available_attires
            ['business casual', 'black tie', 'casual', 'fancy', 'cowboy', 'costume']
        end
        def available_dates
            dates = [Date.current(), Date.current().advance({:days =>  1}), Date.current().advance({:days =>  2}), Date.current().advance({:days =>  3}), Date.current().advance({:days =>  4}), Date.current().advance({:days =>  5}), Date.current().advance({:days =>  6}), Date.current().advance({:days =>  7}), Date.current().advance({:days =>  8}), Date.current().advance({:days =>  9})]
        end
    end

    scope :with_price_range, -> (range) { 
      where(price_range: range)
    }

    scope :with_event_type, -> (types) { 
      where(event_type: types)
    }

    scope :with_date, -> (dates) {
        where("date like ?", "%#{dates}%")
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