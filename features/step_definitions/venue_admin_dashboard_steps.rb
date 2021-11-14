
Given /^(?:|I )am on the "([^"]*)" venue admin dashboard$/ do |venue_admin_name|
    venue_admin = VenueAdmin.where(username: venue_admin_name).first
    venue_admin_id = venue_admin.id
    visit venue_admin_path(venue_admin_id)
end

Then /I should be on the create event page$/ do
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == new_event_path
    else
      assert_equal new_event_path, current_path
    end
end
