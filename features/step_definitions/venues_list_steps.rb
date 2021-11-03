Given /the following venues exist/ do |venues_table|
    venues_table.hashes.each do |venue|
        Venue.create venue
    end
end

When /^(?:|I )go to the venues list page$/ do
    visit venues_path
end

Then /I should be on the venues list page$/ do
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
        current_path.should == venues_path
    else
        assert_equal venues_path, current_path
    end
end

Then /I should see all the venues/ do
    Venue.all.each do |event|
        step %{I should see "#{event.name}"}
    end
end

When /I search venues for (.*)/ do |search|
    Venue.all.each do |event|
        if event.name.include? search
            step %{I should see "#{event.name}"}
        end
    end
end

When /I just filter venues by (.*)/ do |filter|
    Venue.all.each do |event|
        if event.price_range.include?(filter)
            step %{I should see "#{event.name}"}
        elsif event.attire.include? filter
            step %{I should see "#{event.name}"}
        elsif event.event_type.include?(filter)
            step %{I should see "#{event.name}"}
        end
    end
end

When /I now filter venues by (.*) and (.*)/ do |filter1, filter2|
    Venue.all.each do |event|
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

When /I also filter venues by (.*) and (.*) and (.*)/ do |filter1, filter2, filter3|
    Venue.all.each do |event|
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