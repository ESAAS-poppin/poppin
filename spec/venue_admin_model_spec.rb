require 'rails_helper'

RSpec.describe VenueAdmin, :type => :model do
    it "should have defined event types" do
        expect(VenueAdmin.available_venue_types).to match_array(['bar', 'club'])
    end

    it "should have defined attire types" do
        expect(VenueAdmin.available_attires).to match_array(['business_casual', 'black tie', 'casual', 'fancy', 'cowboy'])
    end

    it "should have defined price ranges" do
        expect(VenueAdmin.available_price_ranges).to match_array(['$', '$$', '$$$'])
    end
end