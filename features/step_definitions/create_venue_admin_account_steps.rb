Given /^(?:|I )am on the create venue admin account page$/ do 
    visit new_venue_admin_path
end

Then /I should be on the create venue admin account page$/ do
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == new_venue_admin_path
    else
      assert_equal new_venue_admin_path, current_path
    end
end