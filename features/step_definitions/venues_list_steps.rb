Given /the following venues exist/ do |venues_table|
    venues_table.hashes.each do |venue|
        Venue.create venue
    end
end

When /^(?:|I )go to the venues list page$/ do
    visit venues_path
end

Then /I should be on the venues list page$/ do
    visit venues_path
end

Then /I should see all the venues/ do
    Venue.all.each do |event|
        step %{I should see "#{event.name}"}
    end
end