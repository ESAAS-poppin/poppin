Feature: Venue details rendering and functionality

  As someone looking for details on one venue
  I should be able to see that venue's information
  And also the venue's upcoming events.
  I should also be able to navigate back to the venues list.

Background: events in database
  Given the following venues exist:
  | name         | price_range | venue_type |
  | Sports Bar   |      $$     |    bar     |
  | Rooftop Bar  |      $      |    bar     |
  | Dance Club   |     $$$     |    club    |

  Given the following events exist:
  | name            | price_range |     date     | venue_id |
  | Pitcher Night   |      $$     |   2022-05-25 | 1        |
  | Happy Hour      |      $      |   2021-06-25 | 2        |
  | Halloween Party |     $$$     |   2021-10-31 | 3        |

  And I am logged in

Scenario: go to venues list page from venue details page
  When I go to the "Sports Bar" venue details page
  And I follow "All Venues"
  Then I should be on the venues list page

Scenario: see venue info on the venue details page
  When I go to the "Sports Bar" venue details page
  Then I should see "Sports Bar"
  And I should see "$$"

Scenario: see upcoming events on the venue details page
  When I go to the "Sports Bar" venue details page
  Then I should see "Pitcher Night"

Scenario: no upcoming events on the venue details page
  When I go to the "Rooftop Bar" venue details page
  Then I should see "No upcoming events"

Scenario: save venue
  When I go to the "Rooftop Bar" venue details page
  And I press "Save bar"
  Then I should see "Saved bar"

Scenario: unsave venue
  When I go to the "Sports Bar" venue details page
  And I press "Save bar"
  And I press "Remove saved bar"
  Then I should see "Removed saved bar"