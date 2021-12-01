Feature: Create Event Page rendering and functionality

  As a venue admin of the site
  I should be able to create an event
  And see it displayed in my dashboard

Background: data in database
  Given the following venue admins exist:
  | username  | password | email          |
  | amityHall | password | amity@hall.com |
  | lionshead | password | lions@head.com |

  Given the following venues exist:
  | name         | price_range | venue_type | venue_admin_id | address    |
  | Amity Hall   |      $$     |    bar     | 1              | 123 4th St |

  Given the following events exist:
  | id | name            | price_range |     date     | venue_id |
  | 10 | Pitcher Night   |      $$     |   2021-05-25 | 1        |
  | 11 | Happy Hour      |      $      |   2021-06-25 | 1        |
  | 12 | Halloween Party |     $$$     |   2021-10-31 | 1        |

  And I am logged in to venue admin "amityHall"

Scenario: navigate to create event
  Given I am on the create event page for venue admin "amityHall"
  Then I should see "Create an Event"

Scenario: create an event
  Given I am on the create event page for venue admin "amityHall"
  When I fill in "Event Name" with "Trivia Night"
  And I fill in "Description" with "fun trivia with friends"
  And I fill in "Duration" with "120"
  And I press "Create Event"
  Then I should be on the "Trivia Night" event details page

Scenario: navigate back to the venue admin dashboard page
  Given I am on the create event page for venue admin "amityHall"
  When I follow "My Dashboard"
  Then I should be on the "amityHall" venue admin dashboard