require 'rails_helper'

describe SessionsController, :type => :controller do
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
        expect(response).to redirect_to("/users/1")
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
        expect(session).not_to include(:user_id)
        expect(response).to redirect_to("/sessions/new")
      end
    end
    
end