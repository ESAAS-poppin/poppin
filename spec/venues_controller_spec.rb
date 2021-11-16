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
      it 'fails to get image for nonexistent venue' do
        testUsr = User.new(username: 'test_user_123')
        login(testUsr)
        ven = Venue.create(name:'Dave and Busters', latitude: 10, longitude: -10)
        get :show, params: { id: ven.id }
        expect(:image_url).not_to be_nil
      end
      it 'has a image url with valid lat and long' do
        testUsr = User.new(username: 'test_user_123')
        login(testUsr)
        ven = Venue.create(name:'Amity Hall', latitude: 40.802250, longitude: -73.964616)
        get :show, params: { id: ven.id }
        expect(:image_url).not_to be_nil
      end
    end
    describe 'Update Venue', type: :controller do
      before(:each) do
        testUsr = VenueAdmin.create(username: 'admin_user', password: 'pass', email: 'email@email.com')
        session[:user_id] = testUsr.id
        ven = Venue.create(name:'Dave and Busters', venue_type: 'bar', price_range: '$$', venue_admin_id: 1)
      end

      it 'updates venue information' do
        patch :update, params: { id: 1, venue:{ name: 'test venue 123', address: '951 Amsterdam Ave, New York, NY 10025', description: 'desc', venue_type: 'bar', attire: 'casual', price_range: '$'} }
        expect(Venue.find(1).name).to eq('test venue 123')
      end

      it 'redirects to Venue Admin Dashboard' do
        patch :update, params: { id: 1, venue:{ name: 'test venue 123', address: '951 Amsterdam Ave, New York, NY 10025', description: 'desc', venue_type: 'bar', attire: 'casual', price_range: '$'} }
        expect(response).to redirect_to venue_admin_path
      end

      it 'notifies user of invalid address' do
        patch :update, params: { id: 1, venue:{ name: 'test venue 123', address: '1l23 234k 5j23h434 l2h 3lk 45j4', description: 'desc', venue_type: 'bar', attire: 'casual', price_range: '$'} }
        expect(flash[:notice]).to eq('Invalid address, please specify address in format: street address, city, state zip')
      end
    end
end