Given /the following events exist/ do |events_table|
    events_table.hashes.each do |event|
        Event.create event
    end
end

When /^(?:|I )go to the events list page$/ do
    visit events_path
end

Then /I should be on the events list page$/ do
    visit events_path
end

Then /I should see all the events/ do
    Event.all.each do |event|
        step %{I should see "#{event.name}"}
    end
end