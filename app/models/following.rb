class Following < ApplicationRecord
    belongs_to :user, :class_name => 'User'
    belongs_to :following_user, :class_name => 'User'
end
