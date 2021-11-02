Feature: Events list rendering and functionality

  As someone browsing events
  I should be able to easily see all events and their corresponding venues
  And also navigate to the venues list tab easily

Background: events in database
  Given the following venues exist:
  | name         | price_range | venue_type |
  | Sports Bar   |      $$     |    bar     |
  | Rooftop Bar  |      $      |    bar     |
  | Dance Club   |     $$$     |    club    |

  Given the following events exist:
  | name            | price_range |     date     | venue_id | event_type   | attire  |
  | Pitcher Night   |      $$     |   2021-05-25 | 1        | cheap drinks | casual  |
  | Happy Hour      |      $      |   2021-06-25 | 2        | cheap drinks | casual  |
  | Halloween Party |     $$$     |   2021-10-31 | 3        | party        | costume |

  And I am logged in

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

Scenario: when I search for Happy
  When I go to the events list page
  And I search for "Happy"
  Then I should see "Happy Hour"

Scenario: filter checks
  When I go to the events list page
  And I now filter by "$" and "costume"
  And I press "Go"
  Then I should see ""
  And I now filter by "$" and "casual"
  And I press "Go"
  Then I should see "Happy Hour"
  And I now filter by "$" and "cheap drinks" and "casual"
  And I press "Go"
  Then I should see "Happy Hour"
  And I now filter by "$$" and cheap drinks" and casual
  And I press "Go"
  Then I should see "Pitcher Night"
  And I now filter by "$$$" and "costume" and "party"
  And I press "Go"
  Then I should see "Halloween Party"
  Then I should see ""

