class Venue < ApplicationRecord
    has_many :users, :through => :saved_venues
end
