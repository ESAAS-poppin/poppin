require 'rails_helper'

describe UsersController, :type => :controller do
    describe "check defined" do
        it "should be defined" do
          expect { UsersController }.not_to raise_error
        end
    end

    describe "GET create account page" do
        it "renders the create account page" do
          get :new
          expect(response).to render_template("users/new")
        end
    end

    describe "GET dashboard for caseyo" do
        it "shows dashboard for caseyo" do
          user = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
          User.stub(:find_by).and_return(user)
          get :show, params: { id: 1 }, session: {'user_id' => 1}
          expect(response).to render_template("users/show")
        end
    end

    it 'save venue' do
      testUsr = User.new(username: 'test_user_123')
      login(testUsr)
      ven = Venue.create(name:'Dave and Busters')
      put :save_venue, params: { id: 1, venue_id: ven.id }
      expect(response).to redirect_to(venue_path(1))
      expect(flash[:notice]).to eq("Saved bar")
    end

    it 'save event' do
      testUsr = User.new(username: 'test_user_123')
      login(testUsr)
      evt = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
      put :save_event, params: { id: 1, event_id: 1 }
      expect(response).to redirect_to(event_path(1))
      expect(flash[:notice]).to eq("Saved event")
    end

    it 'unsave event' do
      testUsr = User.new(username: 'test_user_123')
      login(testUsr)
      evt = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
      put :unsave_event, params: { id: 1, event_id: 1 }
      expect(response).to redirect_to(event_path(1))
      expect(flash[:notice]).to eq("Removed saved event")
    end

    it 'unsave venue' do
      testUsr = User.new(username: 'test_user_123')
      login(testUsr)
      ven = Venue.create(name:'Dave and Busters')
      put :unsave_venue, params: { id: 1, venue_id: 1 }
      expect(response).to redirect_to(venue_path(1))
      expect(flash[:notice]).to eq("Removed saved bar")
    end
end