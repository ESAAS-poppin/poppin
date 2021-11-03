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

  Given the following venues exist:
  | name         | price_range | venue_type |
  | Sports Bar   |      $$     |    bar     |
  | Rooftop Bar  |      $      |    bar     |
  | Dance Club   |     $$$     |    club    |

  Given the following events exist:
  | id | name            | price_range |     date     | venue_id |
  | 1 | Pitcher Night   |      $$     |   2021-05-25 | 1        |
  | 2 | Happy Hour      |      $      |   2021-06-25 | 2        |
  | 3 | Halloween Party |     $$$     |   2021-10-31 | 3        |

  Given the following saved_events exist:
  | user_id | event_id |
  | 2       | 2       |

  And I am logged in to "jorger"

Scenario: go to events list page from event details page
  When I go to the "Happy Hour" event details page
  And I follow "All Events"
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
