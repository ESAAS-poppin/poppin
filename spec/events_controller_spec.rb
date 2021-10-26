require 'rails_helper'

describe EventsController do
    describe 'Index', type: :request do
        it 'renders index template' do
          evts = [Event.create(name:'Dancing'), Event.create(name:'Litness')]
          Event.stub(:all).and_return(evts)
          get "/events"
          expect(response).to render_template("events/index")
         end
      end
end