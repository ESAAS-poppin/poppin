Feature: Create Venue Admin Account Page rendering and functionality

  As a new venue admin of the site
  I should be able to create an account

Background: venue admins in database
  Given the following venue admins exist:
  | username  | password | email          |
  | amityHall | password | amity@hall.com |
  | lionshead | password | lions@head.com |

Scenario: create a new account
  Given I am on the create venue admin account page
  When I fill in "Username" with "melsburgers"
  And I fill in "Password" with "password"
  And I fill in "Email" with "mels@burgers.com"
  And I fill in "venue_address" with "951 Amsterdam Ave, New York, NY 10025"
  And I press "Create Account"
  Then I should be on the "melsburgers" venue admin dashboard

Scenario: throw error if username already exists
  Given I am on the create venue admin account page
  When I fill in "Username" with "amityHall"
  And I fill in "Password" with "password"
  And I fill in "Email" with "amityHall@columbia.edu"
  And I press "Create Account"
  Then I should see "Username already exists, please choose another"
  Then I should be on the create venue admin account page

Scenario: navigate back to the login page
  Given I am on the create venue admin account page
  When I follow "Back to Login"
  Then I should be on the login page