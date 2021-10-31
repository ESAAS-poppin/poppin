Given /the following events exist/ do |events_table|
    events_table.hashes.each do |event|
        Event.create event
    end
end

When /^(?:|I )go to the events list page$/ do
    visit events_path
end

Then /I should be on the events list page$/ do
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == events_path
    else
      assert_equal events_path, current_path
    end
end

Then /I should see all the events/ do
    Event.all.each do |event|
        step %{I should see "#{event.name}"}
    end
end