Feature: Venue Admin Dashboard Page rendering and functionality

  As an existing user of the site
  I should be able to log into my account
  And see my saved events and venues

Background: info in database
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

Scenario: Renders the dashboard page
  Given I am on the "amityHall" venue admin dashboard
  Then I should see "Your Business Info"
  Then I should see "Your Events"

Scenario: Click to event list
  Given I am on the "amityHall" venue admin dashboard
  When I follow "Create Event"
  Then I should be on the create event page

Scenario: Sign out of my account
  Given I am on the "amityHall" venue admin dashboard
  When I press "Sign Out"
  Then I should be on the login page
  Then I should see "You have signed out"

Scenario: Update venue
  Given I am on the "amityHall" venue admin dashboard
  When I press "Edit"
  And I fill in "venue_address" with "951 Amsterdam Ave, New York, NY 10025"
  And I press "Update"
  Then I should be on the "amityHall" venue admin dashboard
  And I should not see "123 4th St"
  And I should see "951 Amsterdam Ave, New York, NY 10025"
