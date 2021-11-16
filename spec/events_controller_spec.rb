require 'rails_helper'
require 'spec_helper'

describe EventsController , :type => :controller do
    describe 'Events Index', type: :controller do
        it 'returns all events' do
          testUsr = User.new(username: 'test_user_123')
          login(testUsr)
          evts = [Event.create(name:'Dancing', date:'2021-01-01'), Event.create(name:'Litness', date:'2021-10-01')]
          Event.stub(:all).and_return(evts)
          get :index
          expect(assigns(:events)).to eq evts
         end

         it 'returns events saved by accounts that the user follows' do
          user_1 = User.create(username:'jorger', password: 'password', email: 'jorge@columbia.edu', age:22)
          user_2 = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
          Following.create(user_id: 1, following_user_id: 2)
          Venue.create(name:'Dave and Busters')
          event_1 = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
          SavedEvent.create(user_id: 2, event_id: 1)

  
          session[:user_id] = 1
          expect(session).to include(:user_id)
  
          get :index, :params => { :saved_by => [user_2] }
          expect(assigns(:events)).to eq([event_1])
         end
    end
    describe 'Event mapview' do
      it 'gets correct venues to display' do
        user_1 = User.create(username:'jorger', password: 'password', email: 'jorge@columbia.edu', age:22)
        user_2 = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
        Following.create(user_id: 1, following_user_id: 2)
        Venue.create(name:'Dave and Busters')
        event_1 = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
        events_entry = ["Dancing", nil, nil, nil]
        expected_events = [events_entry]
        session[:user_id] = 1
        expect(session).to include(:user_id)
        get :display_full_map
        expect(assigns(:events)).to eq(expected_events)
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
      

      it 'displays the usernames of accounts that the user follows that have saved this event' do
        user_1 = User.create(username:'jorger', password: 'password', email: 'jorge@columbia.edu', age:22)
        user_2 = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
        Following.create(user_id: 1, following_user_id: 2)
        Venue.create(name:'Dave and Busters')
        Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
        SavedEvent.create(user_id: 2, event_id: 1)

        session[:user_id] = 1
        expect(session).to include(:user_id)

        get :show, :params => { :id => 1 }
        expect(assigns(:friends_who_saved)).to eq([user_2])
      end
    end

    describe "GET create event page", type: :controller do
      it "renders the create event page" do
        get :new, params: {venue_id: 1, venue_admin_id: 1}
        expect(response).to render_template("events/new")
      end

      it "create a new event" do
        venue_admin = VenueAdmin.create(username:'amityHall', password: 'password', email: 'amity@hall.com')
        session[:user_id] = venue_admin.id
        session[:type] = 'venue_admin'
        expect(session).to include(:user_id)
        expect(session).to include(:type)
        venue = Venue.create(name: 'Amity Hall', venue_admin_id: venue_admin.id)

        post :create, params: { event: {name: "Trivia Night", description: "trivia"}, venue_id: 1 }
        expect(response).to redirect_to("/events/1")
      end
  end
end