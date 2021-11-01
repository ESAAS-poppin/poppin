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