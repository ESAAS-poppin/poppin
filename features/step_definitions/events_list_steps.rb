Given /the following events exist/ do |events_table|
    events_table.hashes.each do |event|
        Event.create event
    end
end

When /^(?:|I )go to the events list page$/ do
    visit events_path
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
    click_link(link)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
    if page.respond_to? :should
        page.should have_content(text)
    else
        assert page.has_content?(text)
    end
end

Then /I should be on the Venues list page$/ do
    visit venues_path
end

Then /I should see all the events/ do
    Event.all.each do |event|
        step %{I should see "#{event.name}"}
    end
end