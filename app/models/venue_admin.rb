class VenueAdmin < ApplicationRecord
    has_one :venue
    has_many :events, :through => :venue
end
