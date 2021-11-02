require 'rails_helper'
require 'spec_helper'

describe EventsController do
    describe 'Events Index', type: :controller do
        it 'returns all events' do
          testUsr = User.new(username: 'test_user_123')
          login(testUsr)
          evts = [Event.create(name:'Dancing', date:'2021-01-01'), Event.create(name:'Litness', date:'2021-10-01')]
          Event.stub(:all).and_return(evts)
          get :index
          expect(assigns(:events)).to eq evts
         end
    end
    describe 'Event Venue Name' do
        it 'venue correctly linked to event' do
          ven_1 = Venue.create(name:'Dave and Busters')
          evt = Event.create(name:'Dancing', venue_id:1)
          expect(evt.venue.name).to eq('Dave and Busters')
         end
    end
    describe 'Event details', type: :controller do
      it 'redirects to events if invalid event id' do
        testUsr = User.new(username: 'test_user_123')
        login(testUsr)
        get :show, params: { id: 'hi' }
        expect(response).to redirect_to events_path
      end
      it 'renders correct event details page' do
        testUsr = User.new(username: 'test_user_123')
        login(testUsr)
        ven = Venue.create(name:'Dave and Busters')
        evt_1 = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
        get :show, params: { id: 1 }
        expect(assigns(:event)).not_to eq(nil)
      end
    end
end