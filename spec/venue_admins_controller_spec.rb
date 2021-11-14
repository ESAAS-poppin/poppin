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
        it 'create error on empty username' do
            post :create, params: { venue_admin: {username: ''} }
            expect(flash[:notice]).to eq "Invalid Username."
            expect(response).to redirect_to(new_venue_admin_path)
        end
        it 'create error on existing username' do
            testUsr = VenueAdmin.create(username: 'admin_user', password: 'pass', email: 'email@email.com')
            post :create, params: { venue_admin: {username: 'admin_user'} }
            expect(flash[:notice]).to eq "Username already exists, please choose another"
            expect(response).to redirect_to(new_venue_admin_path)
        end
        it 'create error on invalid address' do
            post :create, params: { venue_admin: {username: 'admin_user', password: 'pass', email: 'email@email.com'}, venue:{ address: 'invalid123'} }
            expect(flash[:notice]).to eq "Invalid address, please specify address in format: street address, city, state zip"
            expect(response).to redirect_to(new_venue_admin_path)
        end
        it 'successful create' do
            post :create, params: { venue_admin: {username: 'admin_user', password: 'pass', email: 'email@email.com'}, venue:{ name: 'test venue 123', address: '951 Amsterdam Ave, New York, NY 10025', description: 'desc', venue_type: 'bar', attire: 'casual', price_range: '$'} }
            expect(session[:user_id]).to eq 1
            created_venue = Venue.find_by_name('test venue 123')
            expect(created_venue).to_not eq nil
        end
    end
end