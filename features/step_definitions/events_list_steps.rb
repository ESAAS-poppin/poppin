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


When /I search for (.*)/ do |search|
    Event.all.each do |event|
        if event.name.include? search
            step %{I should see "#{event.name}"}
        end
    end
end

When /I just filter by (.*)/ do |filter|
    Event.all.each do |event|
        if event.price_range.include?(filter)
            step %{I should see "#{event.name}"}
        elsif event.attire.include? filter
            step %{I should see "#{event.name}"}
        elsif event.event_type.include?(filter)
            step %{I should see "#{event.name}"}
        end
    end
end

When /I now filter by (.*) and (.*)/ do |filter1, filter2|
    Event.all.each do |event|
        if event.price_range.include?(filter1) && event.attire.include?(filter2)
            step %{I should see "#{event.name}"}
        elsif event.price_range.include?(filter2) && event.attire.include?(filter1)
            step %{I should see "#{event.name}"}
        elsif event.price_range.include?(filter1) && event.event_type.include?(filter2)
            step %{I should see "#{event.name}"}
        elsif event.price_range.include?(filter2) && event.event_type.include?(filter1)
            step %{I should see "#{event.name}"}
        elsif event.attire.include?(filter1) && event.event_type.include?(filter2)
            step %{I should see "#{event.name}"}
        elsif event.attire.include?(filter2) && event.event_type.include?(filter1)
            step %{I should see "#{event.name}"}
        end
    end
end

When /I also filter by (.*) and (.*) and (.*)/ do |filter1, filter2, filter3|
    Event.all.each do |event|
        if event.price_range.include?(filter1) && event.attire.include?(filter2) && event.attire.include?(filter3)
            step %{I should see "#{event.name}"}
        elsif event.price_range.include?(filter1) && event.attire.include?(filter3) && event.attire.include?(filter2)
            step %{I should see "#{event.name}"}
        elsif event.price_range.include?(filter2) && event.attire.include?(filter1) && event.attire.include?(filter3)
            step %{I should see "#{event.name}"}
        elsif event.price_range.include?(filter2) && event.attire.include?(filter3) && event.attire.include?(filter1)
            step %{I should see "#{event.name}"}
        elsif event.price_range.include?(filter3) && event.attire.include?(filter1) && event.attire.include?(filter2)
            step %{I should see "#{event.name}"}
        elsif event.price_range.include?(filter3) && event.attire.include?(filter2) && event.attire.include?(filter1)
            step %{I should see "#{event.name}"}
        end
    end
end