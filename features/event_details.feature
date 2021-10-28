Feature: Event details rendering and functionality

  As someone looking for details on one event
  I should be able to see that event's information
  And also which of my friends are attending.
  I should also be able to navigate back to the events list.

Background: events in database
  Given the following events exist:
  | name            | price_range |     date     |
  | Pitcher Night   |      $$     |   2021-05-25 |
  | Happy Hour      |      $      |   2021-06-25 |
  | Halloween Party |     $$$     |   2021-10-31 |

Scenario: go to events list page from event details page
  When I go to the "Happy Hour" event details page
  And I follow "All Events"
  Then I should be on the events list page

Scenario: see which friends are attending the event
