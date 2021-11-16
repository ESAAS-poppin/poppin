require 'rails_helper'

describe SessionsController, :type => :controller do
    before(:each) do
      user = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
      session[:user_id] = 1
      expect(session).to include(:user_id)
    end

    describe "Check defined" do
        it "should be defined" do
          expect { SessionsController }.not_to raise_error
        end
    end

    describe "GET login page" do
        it "renders the login file" do
          get :new
          expect(response).to render_template("sessions/new")
        end
    end

    describe "POST a new session" do
      it "create a new session" do
        user = User.create(username:'caseyo', password: 'password', email: 'casey@columbia.edu', age:22)
        User.stub(:find_by).and_return(user)
        post :create, params: { user: {username: "caseyo", password: "password"} }
        expect(response).to redirect_to("/users/2")
      end

      it "throws error for invalid login" do
        User.stub(:find_by).and_return(nil)
        expect(flash).not_to include(:notice)
        post :create, params: { user: {username: "bad", password: "bad"} }
        expect(response).to redirect_to("/sessions/new")
      end
    end

    describe "DELETE a session" do
      it "log a user out" do
        delete :destroy
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to("/sessions/new")
      end
    end


    describe "CREATE a session for venue admin" do
      it "log in as venue admin" do
        venue_admin = VenueAdmin.create(username:'amityHall', password: 'password', email: 'amity@hall.com')
        session[:user_id] = venue_admin.id
        session[:type] = 'venue admin'
        expect(session).to include(:user_id)
        expect(session).to include(:type)
        post :create, params: { user: {username: "amityHall", password: "password"}, type: 'venue_admin' }
        expect(response).to redirect_to("/venue_admins/1")
      end

      it "throws error for invalid login" do
        VenueAdmin.stub(:find_by).and_return(nil)
        expect(flash).not_to include(:notice)
        post :create, params: { user: {username: "bad", password: "bad"}, type: 'venue_admin' }
        expect(response).to redirect_to("/sessions/new")
      end
    end
    
end