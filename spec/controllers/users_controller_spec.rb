require 'rails_helper'

describe UsersController, :type => :controller do
    before(:each) do
      user = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
      session[:user_id] = 1
      expect(session).to include(:user_id)
    end

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

        it "create a new user" do
          post :create, params: { user: {username: "elies", password: "password", email: "elie@columbia.edu", age:22} }
          expect(response).to redirect_to("/users/2")
        end

        it "throws error for being under 21" do
          post :create, params: { user: {username: "jorger", password: "password", email: "jorge@columbia.edu", age:20} }
          expect(response).to redirect_to("/users/new")
        end

        it "throws error for being an alredy existing username" do
          post :create, params: { user: {username: "caseyo", password: "password", email: "casey@columbia.edu", age:22} }
          expect(response).to redirect_to("/users/new")
        end

        it "throws error for nil username" do
          post :create, params: { user: {username: nil} }
          expect(response).to redirect_to("/users/new")
        end
    end

    describe "check edit/update" do
      it "should render edit page" do
        get :edit, :params => { :id => 1}
        expect(response).to render_template("users/edit")
      end

      it "update existing user" do
        user = User.create(username:'test', password: 'test', email: 'test@test.com')
        session[:user_id] = user.id
        session[:type] = 'user'
        expect(session).to include(:user_id)
        expect(session).to include(:type)

        post :update, params: { user: {username: "updated", password: "updated"}, id: user.id }
        expect(response).to redirect_to(user_path(user.id))
      end
    end

    describe "GET users page" do
      before(:each) do
        User.create(username:'jorger', password: 'password', email: 'jorge@columbia.edu', age:22)
        user = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
        session[:user_id] = 1
        expect(session).to include(:user_id)
      end

      it "renders the users page" do
        get :index
        expect(response).to render_template("users/index")
      end

      it "lists all users" do
        get :index
        expect(assigns(:users)).to eq User.all
      end

      it "returns users that match the search input" do
        get :index, :params => { :search => "jo" }
        expect(assigns(:users)).to eq [User.find_by_username("jorger")]
      end
    end

    describe "PUT following" do
      before(:each) do
        User.create(username:'jorger', password: 'password', email: 'jorge@columbia.edu', age:22)
        user = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
        session[:user_id] = 1
        expect(session).to include(:user_id)
      end

      it "adds a follower for a user" do
        put :follow, :params => { :id => 1, :following_id => 2}
        expect(Following.find_by(user_id: 1, following_user_id: 2)).to be_truthy
      end

      it "removes a follower for a user" do
        Following.create(user_id: 1, following_user_id: 2)
        delete :unfollow, :params => { :id => 1, :following_id => 2}
        expect(Following.find_by(user_id: 1, following_user_id: 2)).to be_nil
      end
    end

    describe "GET dashboard for caseyo" do
        it "shows dashboard for caseyo" do
          user = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
          User.stub(:find_by).and_return(user)
          get :show, params: { id: 2 }, session: {'user_id' => 2}
          expect(response).to render_template("users/show")
        end

        it "assigns upcoming events" do
          testUsr = User.new(username: 'test_user_123')
          login(testUsr)
          ven = Venue.create(name:'Dave and Busters')
          evt = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
          evt_past = Event.create(name:'Very Fun Event', venue_id:1, date: DateTime.strptime("11/01/2020 17:00", "%m/%d/%Y %H:%M"))
          SavedEvent.create(user_id: 1, event_id: 1)
          SavedEvent.create(user_id: 1, event_id: 2)
          get :show, params: { id: 1 }, session: {'user_id' => 1}
          expect(assigns(:events)).to eq [Event.find_by(name: 'Dancing')]
        end

        it "assigns past events" do
          testUsr = User.new(username: 'test_user_123')
          login(testUsr)
          ven = Venue.create(name:'Dave and Busters')
          evt = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
          evt_past = Event.create(name:'Very Fun Event', venue_id:1, date: DateTime.strptime("11/01/2020 17:00", "%m/%d/%Y %H:%M"))
          SavedEvent.create(user_id: 1, event_id: 1)
          SavedEvent.create(user_id: 1, event_id: 2)
          get :show, params: { id: 1, past: true }, session: {'user_id' => 1}
          expect(assigns(:events)).to eq [Event.find_by(name: 'Very Fun Event')]
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
      ven = Venue.create(name:'Dave and Busters')
      evt = Event.create(name:'Dancing', venue_id:1, date: DateTime.strptime("11/01/2022 17:00", "%m/%d/%Y %H:%M"))
      SavedEvent.create(user_id: 1, event_id: 1)
      delete :unsave_event, params: { id: 1, event_id: 1 }
      expect(SavedEvent.find_by(user_id: 1, event_id: 1)).to be_nil
      expect(response).to redirect_to(event_path(1))
      expect(flash[:notice]).to eq("Removed saved event")
    end

    it 'unsave venue' do
      testUsr = User.new(username: 'test_user_123')
      login(testUsr)
      ven = Venue.create(name:'Dave and Busters')
      SavedVenue.create(user_id: 1, venue_id: 1)
      delete :unsave_venue, params: { id: 1, venue_id: 1 }
      expect(SavedVenue.find_by(user_id: 1, venue_id: 1)).to be_nil
      expect(response).to redirect_to(venue_path(1))
      expect(flash[:notice]).to eq("Removed saved bar")
    end
end