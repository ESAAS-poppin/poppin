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
    
end