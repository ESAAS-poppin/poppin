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
    describe 'Venue Details', type: :controller do
      it 'venue_events empty' do
        testUsr = User.new(username: 'test_user_123')
        login(testUsr)
        ven = Venue.create(name:'Dave and Busters')
        evt_1 = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2020 17:00", "%m/%d/%Y %H:%M"))
        get :show, params: { id: ven.id }
        expect(assigns(:venue_events).length()).to eq(0)
      end
      it 'venue_events includes an upcoming event' do
        testUsr = User.new(username: 'test_user_123')
        login(testUsr)
        ven = Venue.create(name:'Dave and Busters')
        evt_1 = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
        get :show, params: { id: ven.id }
        expect(assigns(:venue_events).length()).to eq(1)
      end
      it 'redirects to venues if invalid venue id' do
        testUsr = User.new(username: 'test_user_123')
        login(testUsr)
        get :show, params: { id: 'hi' }
        expect(response).to redirect_to venues_path
      end
    end
end