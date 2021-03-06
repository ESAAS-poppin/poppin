require 'rails_helper'

RSpec.describe Event, :type => :model do
    it "should have defined event types" do
        expect(Event.available_event_types).to match_array(['trivia', 'live music', 'dancing', 'sports', 'cheap drinks', 'party', 'brunch'])
    end

    it "should have defined attire types" do
        expect(Event.available_attires).to match_array(['business casual', 'black tie', 'casual', 'fancy', 'cowboy', 'costume'])
    end

    it "should have defined price ranges" do
        expect(Event.available_price_ranges).to match_array(['$', '$$', '$$$'])
    end

    it "should have defined dates" do
        expect(Event.available_dates).to match_array([Date.current(), Date.current().advance({:days =>  1}), Date.current().advance({:days =>  2}), Date.current().advance({:days =>  3}), Date.current().advance({:days =>  4}), Date.current().advance({:days =>  5}), Date.current().advance({:days =>  6}), Date.current().advance({:days =>  7}), Date.current().advance({:days =>  8}), Date.current().advance({:days =>  9})])
    end

    it "should have working scopes" do
        ven_1 = Venue.create(name:'Dave and Busters')
        events = Event.create!({name: "hello", address: nil, description: nil, event_type: "dancing", attire: "casual", price_range: "$$", venue_id: 1, date: Date.current, duration: nil, image_url: nil, created_at: nil, updated_at: nil})
        expect(Event.with_price_range("$$$")).not_to include(events)
        expect(Event.with_attire("business casual")).not_to include(events)
        expect(Event.with_event_type("dancing")).to include(events)
        expect(Event.with_price_range("$$")).to include(events)
        expect(Event.with_date(Date.current)).to include(events)  
        expect(Event.with_attire("casual")).to include(events)
        expect(Event.with_event_type("trivia")).not_to include(events)
        expect(Event.search("hello")).to include(events)
    end
end