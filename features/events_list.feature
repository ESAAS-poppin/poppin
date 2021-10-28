Feature: Events list rendering and functionality

  As someone browsing events
  I should be able to easily see all events and their corresponding venues
  And also navigate to the venues list tab easily

Background: events in database
  Given the following events exist:
  | name            | price_range |     date     |
  | Pitcher Night   |      $$     |   2021-05-25 |
  | Happy Hour      |      $      |   2021-06-25 |
  | Halloween Party |     $$$     |   2021-10-31 |

Scenario: correct events rendered
  When I go to the events list page
  Then I should see all the events

Scenario: go to Venues list page from Events list page
  When I go to the events list page
  And I follow "Venues"
  Then I should be on the venues list page

Scenario: go to details list page from Events list page
  When I go to the events list page
  And I follow "Halloween Party"
  Then I should be on the "Halloween Party" event details page
