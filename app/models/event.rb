class Event < ApplicationRecord
    attr_accessor :venue_name
    def self.event_type
        ['Trivia', 'Live Music', 'Dancing', 'Sports']
    end
    def self.price_range
        ['$', '$$', '$$$']
    end
    def self.attire
        ['Buisness Casual', 'Black Tie', 'Casual', 'Fancy']
    end
    has_many :users, :through => :saved_events
    belongs_to :venue
end