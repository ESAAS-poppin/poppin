require 'rails_helper'
require 'spec_helper'

describe VenueAdminsController do
    describe 'Venue Admin controller functions', type: :controller do
        it 'new assigns venue_admin' do
          get :new
          expect(assigns(:venue_admin)).not_to eq nil
          expect(response).to render_template("venue_admins/new")
        end
        it 'show correctly assigns venue and events' do
            testUsr = VenueAdmin.create(username: 'admin_user', password: 'pass', email: 'email@email.com')
            session[:user_id] = testUsr.id
            ven = Venue.create(name:'Dave and Busters', venue_admin_id: 1)
            evt_1 = Event.create(name:'Dancing', venue_id:1)
            get :show, params: { id: 1 }, session: {'user_id' => 1}
            expect(assigns(:venue)).to eq ven
            expect(assigns(:events)).to eq [evt_1]
            expect(response).to render_template("venue_admins/show")
        end
    end
end