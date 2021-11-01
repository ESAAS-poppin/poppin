# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
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


venues = [{:name => 'Amity Hall', :address => '123 4th st', :description => 'bar near columbia', :venue_type => 'bar', :attire => 'casual', :price_range => '$$', :latitude => 40.802250, :longitude => -73.964616, :image_url => ''},
          {:name => 'Lion\'s Head', :address => '234 5th st', :description => 'bar with outdoor seating', :venue_type => 'bar', :attire => 'casual', :price_range => '$', :latitude => 40.802256, :longitude => -73.964269, :image_url => ''},
    	  {:name => '1020', :address => '345 6th st', :description => 'bar near columbia', :venue_type => 'bar', :attire => 'casual', :price_range => '$$', :latitude => 40.8033355, :longitude => -73.9640311, :image_url => ''},
          {:name => 'Mel\'s Burger Bar', :address => '456 7th st', :description => 'bar near columbia with cornhole', :venue_type => 'club', :attire => 'casual', :price_range => '$$$', :latitude => 40.78775, :longitude => -73.9788558, :image_url => ''},
  	 ]

venues.each do |venue|
  Venue.create!(venue)
end

events = [{:name => 'Trivia Night', 
                :address => '123 4th st', 
                :description => 'grab your friends to play trivia!', 
                :event_type => 'trivia', 
                :attire => 'casual', 
                :price_range => '$$', 
                :venue_id => 1,
                :date => DateTime.strptime("10/30/2021 18:00", "%m/%d/%Y %H:%M"),
                :duration => 120,
                :latitude => 40.802250, 
                :longitude => -73.964616,
                :image_url => ''},
          {:name => 'Line Dancing', 
                :address => '345 5th st', 
                :description => 'country music and line dancing', 
                :event_type => 'dancing', 
                :attire => 'cowboy', 
                :price_range => '$$', 
                :venue_id => 3,
                :date => DateTime.strptime("11/01/2021 17:00", "%m/%d/%Y %H:%M"),
                :duration => 180,
                :latitude => 40.802250, 
                :longitude => -73.964616, 
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