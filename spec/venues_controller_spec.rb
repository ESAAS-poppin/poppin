require 'rails_helper'

describe VenuesController do
    describe 'Venues Index', type: :request do
        it 'renders index template' do
          venues = [Venue.create(name:'Bobbys Bar and Grill'), Venue.create(name:'Chuck E Cheez')]
          Event.stub(:all).and_return(venues)
          get "/venues"
          expect(response).to render_template("venues/index")
         end
      end
end