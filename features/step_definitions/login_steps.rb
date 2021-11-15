
Given /^(?:|I )am on the login page$/ do 
    visit new_sessions_path
end

Given /the following users exist/ do |user_table|
    user_table.hashes.each do |user|
        User.create user
    end
end

Given /the following venue admins exist/ do |va_table|
  va_table.hashes.each do |va|
      VenueAdmin.create va
  end
end

When /^(?:|I )go to the login page$/ do
    visit new_sessions_path
end

When /^(?:|I )choose "([^"]*)"$/ do |user_type|
  choose(user_type)
end

Then /I should be on the "([^"]*)" user dashboard$/ do |user_name|
    user = User.where(username: user_name).first
    user_id = user.id
    
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == user_path(user_id)
    else
      assert_equal user_id(user_id), current_path
    end
end

Then /I should be on the login page$/ do
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == new_sessions_path
    else
      assert_equal new_sessions_path, current_path
    end
end

Then /I should be on the "([^"]*)" venue admin dashboard$/ do |venue_admin_name|
  venue_admin = VenueAdmin.where(username: venue_admin_name).first
  venue_admin_id = venue_admin.id
  
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == venue_admin_path(venue_admin_id)
  else
    assert_equal venue_admin_path(venue_admin_id), current_path
  end
end