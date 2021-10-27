class User < ApplicationRecord
    #has_secure_password

    has_many :saved_venues
    has_many :saved_events
    has_many :followings
    has_many :events, :through => :saved_events
    has_many :venues, :through => :saved_venues

end
