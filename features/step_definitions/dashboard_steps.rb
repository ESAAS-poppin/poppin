Given /the following saved_events exist/ do |se_table|
    se_table.hashes.each do |event|
        SavedEvent.create event
    end
end

Given /the following saved_venues exist/ do |sv_table|
    sv_table.hashes.each do |venue|
        SavedVenue.create venue
    end
end

Given /^(?:|I )am on the "([^"]*)" dashboard page$/ do |user_name|
    user = User.where(username: user_name).first
    user_id = user.id
    visit user_path(user_id)
end

Then /I should be on the "([^"]*)" edit profile page$/ do |user_name|
    user = User.where(username: user_name).first
    user_id = user.id

    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == edit_user_path(user_id)
    else
      assert_equal edit_user_path(user_id), current_path
    end
end