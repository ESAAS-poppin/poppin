require 'rails_helper'
require 'spec_helper'

describe VenuesController do
    describe 'Venues Index', type: :controller do
        it 'returns all venues' do
          testUsr = User.new(username: 'test_user_123')
          login(testUsr)
          venues = [Venue.create(name:'Bobbys Bar and Grill'), Venue.create(name:'Chuck E Cheez')]
          Venue.stub(:all).and_return(venues)
          get :index
          expect(assigns(:venues)).to eq venues
         end
    end
    describe 'Venue has correct events' do
      it 'venue correctly linked to event' do
        ven = Venue.create(name:'Dave and Busters')
        evt_1 = Event.create(name:'Dancing', venue_id:1)
        expect(ven.events.first.name).to eq('Dancing')
       end
  end
end