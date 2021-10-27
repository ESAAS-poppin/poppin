require 'rails_helper'

describe EventsController do
    describe 'Events Index', type: :request do
        it 'renders index template' do
          evts = [Event.create(name:'Dancing', date:'2021-01-01'), Event.create(name:'Litness', date:'2021-10-01')]
          Event.stub(:all).and_return(evts)
          get "/events"
          expect(response).to render_template("events/index")
         end
    end
    describe 'Event Venue Name' do
        it 'correctly sets the venue_name field' do
          ven_1 = Venue.create(name:'Dave and Busters')
          evt = Event.create(name:'Dancing', venue_id:1)
          Event.add_venue_name(evt)
          expect(evt.venue_name).to eq('Dave and Busters')
         end
    end
end