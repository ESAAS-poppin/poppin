class Event < ApplicationRecord
    attr_accessor :venue_name

    has_many :users, :through => :saved_events
    belongs_to :venue

    def self.saved_by(users)
        byebug
        if !users or !users.kind_of?(Array) or users.length < 1
            return Event.all
        else
            saved_events = SavedEvent.where(user_id: users)
            return Event.where(id: saved_events.map {|event| event.event_id})
        end
    end
end