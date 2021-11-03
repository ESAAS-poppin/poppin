require 'rails_helper'

RSpec.describe Venue, :type => :model do
    it "should have defined event types" do
        expect(Venue.available_venue_types).to match_array(['bar', 'club'])
    end

    it "should have defined attire types" do
        expect(Venue.available_attires).to match_array(['business casual', 'black tie', 'casual', 'fancy', 'cowboy'])
    end

    it "should have defined price ranges" do
        expect(Venue.available_price_ranges).to match_array(['$', '$$', '$$$'])
    end

    it "should have working scopes" do
        venues = Venue.create(name: "hello", venue_type: "bar", attire: "casual", price_range: "$$")
        evt = Event.create(name:'Dancing', venue_id:1)
        expect(Venue.with_price_range("$$$")).not_to include(venues)
        expect(Venue.with_attire("")).not_to include(venues)
        expect(Venue.with_venue_type("bar")).to include(venues)
        expect(Venue.with_price_range("$$")).to include(venues) 
        expect(Venue.with_attire("casual")).to include(venues)
        expect(Venue.with_venue_type("club")).not_to include(venues)
        expect(Venue.search("hello")).to include(venues)
    end
end