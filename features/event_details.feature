Feature: Event details rendering and functionality

  As someone looking for details on one event
  I should be able to see that event's information
  And also which of my friends are attending.
  I should also be able to navigate back to the events list.

Background: events in database
  Given the following users exist:
  | id | username | password | email              | image_url | age |
  | 1  | jorger   | password | jorge@columbia.edu | ''        | 22  |
  | 2  | elies    | password | elie@columbia.edu  | ''        | 24  |

  Given the following followings exist:
  | user_id | following_user_id |
  | 1       | 2       |

  Given the following venue admins exist:
  | username  | password | email          |
  | sportsBar | password | sb@sports.com |

  Given the following venues exist:
  | name         | price_range | venue_type |   address  | venue_admin_id |
  | Sports Bar   |      $$     |    bar     | 123 4th St |   1    |
  | Rooftop Bar  |      $      |    bar     | 123 4th St |   1    |
  | Dance Club   |     $$$     |    club    | 123 4th St |   1    |

  Given the following events exist:
  | id | name            | price_range |     date     | venue_id | duration |
  | 1 | Pitcher Night   |      $$     |   2022-05-25 | 1        | 122 |
  | 2 | Happy Hour      |      $      |   2021-06-25 | 2        | 120 |
  | 3 | Halloween Party |     $$$     |   2021-10-31 | 3        | 120 |

  Given the following saved_events exist:
  | user_id | event_id |
  | 2       | 2       |

  And I am logged in to "jorger"

Scenario: go to events list page from event details page
  When I go to the "Happy Hour" event details page
  And I follow "Search Events"
  Then I should be on the events list page

Scenario: see which friends are attending the event
  When I go to the "Happy Hour" event details page
  Then I should see user 'elies'

Scenario: save event
  When I go to the "Happy Hour" event details page
  And I press "Save event"
  Then I should see "Saved event"

Scenario: unsave event
  When I go to the "Happy Hour" event details page
  And I press "Save event"
  And I press "Remove saved event"
  Then I should see "Removed saved event"

Scenario: update event
  Given I am logged in to venue admin "sportsBar"
  And I am on the "sportsBar" venue admin dashboard
  When I follow "Pitcher Night"
  And I press "Edit"
  And I fill in "event_duration" with "123"
  And I press "Update"
  Then I should be on the "Pitcher Night" event details page
  And I should not see "122"
  And I should see "123"

Scenario: should not see update event if not admin
  Given I am logged in to "jorger"
  When I go to the "Pitcher Night" event details page
  Then I should not see "Edit"