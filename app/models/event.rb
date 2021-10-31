class Event < ApplicationRecord
    attr_accessor :venue_name

    has_many :users, :through => :saved_events
end