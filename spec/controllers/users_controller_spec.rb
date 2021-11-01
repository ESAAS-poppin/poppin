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
end