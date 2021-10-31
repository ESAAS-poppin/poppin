Feature: Venues list rendering and functionality

  As someone browsing venues
  I should be able to easily see all venue summaries
  And also navigate to the venue details or events list tab easily

Background: venues in database
  Given the following venues exist:
  | name         | price_range | venue_type |
  | Sports Bar   |      $$     |    bar     |
  | Rooftop Bar  |      $      |    bar     |
  | Dance Club   |     $$$     |    club    |

  And I am logged in

Scenario: correct venues rendered
  When I go to the venues list page
  Then I should see all the venues

Scenario: go to Events list page from Venues list page
  When I go to the venues list page
  And I follow "Events"
  Then I should be on the events list page

Scenario: go to details list page from Venues list page
  When I go to the venues list page
  And I follow "Sports Bar"
  Then I should be on the "Sports Bar" venue details page
