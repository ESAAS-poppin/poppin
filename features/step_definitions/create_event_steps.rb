Given /^(?:|I )am on the create event page for venue admin "([^"]*)"$/ do |venue_admin_name|
    venue_admin = VenueAdmin.find_by(username: venue_admin_name)
    venue_admin_id = venue_admin.id

    venue = Venue.find_by(venue_admin_id: venue_admin_id)
    venue_id = venue.id

    visit new_event_path(venue_id: venue_id, venue_admin_id: venue_admin_id)
end
