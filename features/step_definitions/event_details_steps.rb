When /I go to the "([^"]*)" event details page$/ do |event_name|
    evt = Event.where(name: event_name).first
    evt_id = evt.id
    visit event_path(evt_id)
end

Then /I should be on the "([^"]*)" event details page$/ do |event_name|
    evt = Event.where(name: event_name).first
    evt_id = evt.id
    
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == event_path(evt_id)
    else
      assert_equal event_path(evt_id), current_path
    end
end