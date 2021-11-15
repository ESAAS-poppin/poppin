# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [{:username => 'caseyo', :password => 'password', :email => 'casey@columbia.edu', :image_url => '', :age => 22},
    	  {:username => 'elies', :password => 'password', :email => 'elie@columbia.edu', :image_url => '', :age => 24},
    	  {:username => 'jorger', :password => 'password', :email => 'jorge@columbia.edu', :image_url => '', :age => 22},
          {:username => 'ryank', :password => 'password', :email => 'ryan@columbia.edu', :image_url => '', :age => 22},
  	 ]

users.each do |user|
  User.create!(user)
end

venue_admins = [{:username => 'amityHall', :password => 'password', :email => 'amity@hall.com'},
          {:username => 'lionshead', :password => 'password', :email => 'lion@heads.com'},
          {:username => 'melsburgerbar', :password => 'password', :email => 'mels@burgerbar.com'},
          {:username => '1020', :password => 'password', :email => '10@20.com'}
  	 ]

venue_admins.each do |venue_admin|
  VenueAdmin.create!(venue_admin)
end


venues = [{:name => 'Amity Hall', :address => '982 Amsterdam Ave, New York, NY, 10025', :description => 'bar near columbia', :venue_type => 'bar', :attire => 'casual', :price_range => '$$', :latitude => 40.8022491, :longitude => -73.9646077, :image_url => '', :venue_admin_id => 1},
          {:name => 'Lion\'s Head', :address => '995 Amsterdam Avenue, New York, NY, 10025', :description => 'bar with outdoor seating', :venue_type => 'bar', :attire => 'casual', :price_range => '$', :latitude => 40.802198, :longitude => -73.9642063, :image_url => '', :venue_admin_id => 2},
    	    {:name => '1020', :address => '1020 Amsterdam Avenue, New York, NY, 10025', :description => 'bar near columbia', :venue_type => 'bar', :attire => 'casual', :price_range => '$$', :latitude => 40.8033668, :longitude => -73.9638017, :image_url => '', :venue_admin_id => 4},
          {:name => 'Mel\'s Burger Bar', :address => '2850 Broadway, New York, NY, 10025', :description => 'bar near columbia with cornhole', :venue_type => 'club', :attire => 'casual', :price_range => '$$$', :latitude => 40.8044959, :longitude => -73.9661283, :image_url => '', :venue_admin_id => 3},
  	 ]

venues.each do |venue|
  Venue.create!(venue)
end

events = [{:name => 'Trivia Night', 
                :address => '982 Amsterdam Ave, New York, NY, 10025', 
                :description => 'grab your friends to play trivia!', 
                :event_type => 'trivia', 
                :attire => 'casual', 
                :price_range => '$$', 
                :venue_id => 1,
                :date => DateTime.strptime("11/19/2022 18:00", "%m/%d/%Y %H:%M"),
                :duration => 120,
                :latitude => 40.8022491, 
                :longitude => -73.9646077,
                :image_url => ''},
          {:name => 'Senior Night', 
                :address => '982 Amsterdam Ave, New York, NY, 10025', 
                :description => 'Get cheap drinks and celebrate with fellow columbia seniors!', 
                :event_type => 'cheap drinks', 
                :attire => 'casual', 
                :price_range => '$', 
                :venue_id => 1,
                :date => DateTime.strptime("11/19/2022 19:00", "%m/%d/%Y %H:%M"),
                :duration => 180,
                :latitude => 40.8022491, 
                :longitude => -73.9646077,
                :image_url => ''},
          {:name => 'LFT Brunch', 
                :address => '995 Amsterdam Avenue, New York, NY, 10025', 
                :description => 'Join us for brunch starting @ 10 AM!', 
                :event_type => 'brunch', 
                :attire => 'casual', 
                :price_range => '$$', 
                :venue_id => 2,
                :date => DateTime.strptime("11/20/2022 10:00", "%m/%d/%Y %H:%M"),
                :duration => 120,
                :latitude => 40.802198, 
                :longitude => -73.9642063,
                :image_url => ''},
          {:name => 'LFT Brunch', 
                :address => '995 Amsterdam Avenue, New York, NY, 10025', 
                :description => 'Join us for brunch starting @ 10 AM!', 
                :event_type => 'brunch', 
                :attire => 'casual', 
                :price_range => '$$', 
                :venue_id => 2,
                :date => DateTime.strptime("11/21/2022 10:00", "%m/%d/%Y %H:%M"),
                :duration => 120,
                :latitude => 40.802198, 
                :longitude => -73.9642063,
                :image_url => ''},
          {:name => 'NFL Watch Party', 
                :address => '995 Amsterdam Avenue, New York, NY, 10025', 
                :description => 'Enjoy footbal with TVs indoors and out, along with raffles and giveaways!', 
                :event_type => 'sports', 
                :attire => 'casual', 
                :price_range => '$$', 
                :venue_id => 2,
                :date => DateTime.strptime("11/21/2022 13:00", "%m/%d/%Y %H:%M"),
                :duration => 240,
                :latitude => 40.802198, 
                :longitude => -73.9642063,
                :image_url => ''},
          {:name => 'Line Dancing', 
                :address => '1020 Amsterdam Avenue, New York, NY, 10025', 
                :description => 'country music and line dancing', 
                :event_type => 'dancing', 
                :attire => 'cowboy', 
                :price_range => '$$', 
                :venue_id => 3,
                :date => DateTime.strptime("11/21/2021 17:00", "%m/%d/%Y %H:%M"),
                :duration => 180,
                :latitude => 40.8044959, 
                :longitude => -73.9638017, 
                :image_url => ''},
          {:name => 'NFL Watch Party', 
                :address => '2850 Broadway, New York, NY, 10025', 
                :description => 'Enjoy footbal with TVs indoors and out, and get a great burger!', 
                :event_type => 'sports', 
                :attire => 'casual', 
                :price_range => '$$', 
                :venue_id => 4,
                :date => DateTime.strptime("11/21/2021 13:00", "%m/%d/%Y %H:%M"),
                :duration => 240,
                :latitude => 40.8044959, 
                :longitude => -73.9661283,
                :image_url => ''},
  	 ]

events.each do |event|
  Event.create!(event)
end

followings = [{:user_id => 1, :following_user_id => 2},
          {:user_id => 1, :following_user_id => 3},
          {:user_id => 1, :following_user_id => 4},
    	  {:user_id => 2, :following_user_id => 1},
          {:user_id => 2, :following_user_id => 4},
          {:user_id => 3, :following_user_id => 2},
          {:user_id => 4, :following_user_id => 1},
          {:user_id => 4, :following_user_id => 3},
  	 ]

followings.each do |following|
  Following.create!(following)
end

saved_events = [{:user_id => 1, :event_id => 1},
          {:user_id => 1, :event_id => 2},
          {:user_id => 2, :event_id => 1},
    	  {:user_id => 3, :event_id => 2},
          {:user_id => 4, :event_id => 1},
          {:user_id => 4, :event_id => 2},
  	 ]

saved_events.each do |saved_event|
  SavedEvent.create!(saved_event)
end

saved_venues = [{:user_id => 1, :venue_id => 2},
          {:user_id => 1, :venue_id => 3},
          {:user_id => 1, :venue_id => 4},
    	  {:user_id => 2, :venue_id => 1},
          {:user_id => 2, :venue_id => 4},
          {:user_id => 3, :venue_id => 2},
          {:user_id => 4, :venue_id => 1},
          {:user_id => 4, :venue_id => 3},
  	 ]

saved_venues.each do |saved_venue|
  SavedVenue.create!(saved_venue)
end

