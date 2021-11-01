class User < ApplicationRecord
    #has_secure_password

    has_many :saved_venues
    has_many :saved_events
    has_many :followings
    has_many :events, :through => :saved_events
    has_many :venues, :through => :saved_venues

    def self.search(search_text)
        if search_text

            return User.where("username LIKE ?", "%#{search_text}%")
        else
            return User.all
        end
    end

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

end
