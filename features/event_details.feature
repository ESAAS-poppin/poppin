Feature: Event details rendering and functionality

  As someone looking for details on one event
  I should be able to see that event's information
  And also which of my friends are attending.
  I should also be able to navigate back to the events list.

Background: events in database
  Given the following venues exist:
  | name         | price_range | venue_type |
  | Sports Bar   |      $$     |    bar     |
  | Rooftop Bar  |      $      |    bar     |
  | Dance Club   |     $$$     |    club    |

  Given the following events exist:
  | name            | price_range |     date     | venue_id |
  | Pitcher Night   |      $$     |   2021-05-25 | 1        |
  | Happy Hour      |      $      |   2021-06-25 | 2        |
  | Halloween Party |     $$$     |   2021-10-31 | 3        |

  And I am logged in

Scenario: go to events list page from event details page
  When I go to the "Happy Hour" event details page
  And I follow "All Events"
  Then I should be on the events list page

Scenario: see which friends are attending the event
  # Given I am logged in to "jorger"
  # When I go to the "Happy Hour" event details page
  # Then I should see event "Pitcher Night"
  # And I should not see events "Happy Hour", "Halloween Party"

Scenario: save event
  When I go to the "Happy Hour" event details page
  And I press "Save event"
  Then I should see "Saved event"

Scenario: unsave event
  When I go to the "Happy Hour" event details page
  And I press "Save event"
  And I press "Remove saved event"
  Then I should see "Removed saved event"
