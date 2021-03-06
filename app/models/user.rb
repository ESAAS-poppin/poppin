class User < ApplicationRecord
    #has_secure_password

    has_many :saved_venues
    has_many :saved_events
    has_many :followings
    has_many :events, :through => :saved_events
    has_many :venues, :through => :saved_venues
    has_one_attached :profile_image

    def self.search(search_text)
        if search_text

            return User.where("username LIKE ?", "%#{search_text}%")
        else
            return User.all
        end
    end

    scope :followed_by, -> (user_id) {
        followings = Following.where(user_id: user_id)
        where(id: followings.map { |following| following.following_user_id })
    }

    scope :that_saved_event, -> (event_id) {
        saved_events = SavedEvent.where(event_id: event_id)
        where(id: saved_events.map { |saved_event| saved_event.user_id })
    }

    scope :that_saved_venue, -> (venue_id) {
        saved_venues = SavedVenue.where(venue_id: venue_id)
        where(id: saved_venues.map { |saved_venue| saved_venue.user_id })
    }

    def self.follow(user_id, following_user_id)
        # TODO: check valid id
        following = Following.find_by(user_id: user_id, following_user_id: following_user_id)
        if following
            # TODO: consider error
        else
            Following.create(user_id: user_id, following_user_id: following_user_id)
        end
    end

    def self.unfollow(user_id, following_user_id)
        following = Following.find_by(user_id: user_id, following_user_id: following_user_id)
        if following
            following.delete
        else
            # TODO: consider error
        end
    end

    def self.follows?(user_id, following_user_id)
        return Following.find_by(user_id: user_id, following_user_id: following_user_id) != nil
    end

    def self.save_event(user_id, event_id)
        # TODO: check valid id
        saved = SavedEvent.find_by(user_id: user_id, event_id: event_id)
        if saved
            # TODO: consider error
        else
            SavedEvent.create(user_id: user_id, event_id: event_id)
        end
    end

    def self.unsave_event(user_id, event_id)
        saved = SavedEvent.find_by(user_id: user_id, event_id: event_id)
        if saved
            saved.delete
        else
            # TODO: consider error
        end
    end

    def self.is_event_saved?(user_id, event_id)
        return SavedEvent.find_by(user_id: user_id, event_id: event_id) != nil
    end

    def self.save_venue(user_id, venue_id)
        # TODO: check valid id
        saved = SavedVenue.find_by(user_id: user_id, venue_id: venue_id)
        if saved
            # TODO: consider error
        else
            SavedVenue.create(user_id: user_id, venue_id: venue_id)
        end
    end

    def self.unsave_venue(user_id, venue_id)
        saved = SavedVenue.find_by(user_id: user_id, venue_id: venue_id)
        if saved
            saved.delete
        else
            # TODO: consider error
        end
    end

    def self.is_venue_saved?(user_id, venue_id)
        return SavedVenue.find_by(user_id: user_id, venue_id: venue_id) != nil
    end
end
