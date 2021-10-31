When /I go to the "([^"]*)" venue details page$/ do |venue_name| 
    ven = Venue.where(name: venue_name).first
    ven_id = ven.id
    visit venue_path(ven_id)
  end
  
  Then /I should be on the "([^"]*)" venue details page$/ do |venue_name|
      ven = Venue.where(name: venue_name).first
      ven_id = ven.id
      
      current_path = URI.parse(current_url).path
      if current_path.respond_to? :should
        current_path.should == venue_path(ven_id)
      else
        assert_equal venue_path(ven_id), current_path
      end
  end