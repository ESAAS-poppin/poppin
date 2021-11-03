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

    describe "is_event_saved? function" do
        it "should return true if the user has the event saved" do
            user_1 = User.create(username:'jorger', password: 'password', email: 'jorge@columbia.edu', age:22)
            ven = Venue.create(name:'Dave and Busters')
            evt = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
            SavedEvent.create(user_id: 1, event_id: 1)
            expect(User.is_event_saved?(user_1, evt)).to be_truthy
        end
    end

    describe "is_venue_saved? function" do
        it "should return true if the user has the venue saved" do
            user_1 = User.create(username:'jorger', password: 'password', email: 'jorge@columbia.edu', age:22)
            ven = Venue.create(name:'Dave and Busters')
            SavedVenue.create(user_id: 1, venue_id: 1)
            expect(User.is_venue_saved?(user_1, ven)).to be_truthy
        end
    end
end