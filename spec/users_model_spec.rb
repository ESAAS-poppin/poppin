require 'rails_helper'

RSpec.describe User, :type => :model do

    describe "follows? function" do
        it "should return true if the user follows the given account" do
            user_1 = User.create(username:'jorger', password: 'password', email: 'jorge@columbia.edu', age:22)
            user_2 = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
            Following.create(user_id: 1, following_user_id: 2)
            expect(User.follows?(user_1, user_2)).to be_truthy
        end

        it "should return false if the user does not follow the given account" do
            user_1 = User.create(username:'jorger', password: 'password', email: 'jorge@columbia.edu', age:22)
            user_2 = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
            expect(User.follows?(user_2, user_1)).to be_falsey
        end
    end
end