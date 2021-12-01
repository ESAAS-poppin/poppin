Feature: Login Page rendering and functionality

  As an existing user of the site
  I should be able to log into my account
  And see my saved events and venues

Background: users in database
  Given the following users exist:
  | username | password | email              | image_url | age |
  | caseyo   | password | casey@columbia.edu | ''        | 22  |
  | elies    | password | elie@columbia.edu  | ''        | 24  |
  | jorger   | password | jorge@columbia.edu | ''        | 22  |
  | ryank    | password | ryan@columbia.edu  | ''        | 22  |

  Given the following venue admins exist:
  | username  | password | email          |
  | amityHall | password | amity@hall.com |
  | lionshead | password | lions@head.com |

  Given the following venues exist:
  | name         | price_range | venue_type | venue_admin_id |
  | Amity Hall   |      $$     |    bar     | 1              |

Scenario: login page rendered
  When I go to the login page
  Then I should see "Welcome to Poppin"

Scenario: login as user with valid account
  Given I am on the login page
  When I choose "type_user"
  When I fill in "Username" with "caseyo"
  And I fill in "Password" with "password"
  And I press "Login"
  Then I should be on the "caseyo" user dashboard

Scenario: login as user with invalid account stays on login page
  Given I am on the login page
  When I choose "type_user"
  When I fill in "Username" with "idontexist"
  And I fill in "Password" with "password"
  And I press "Login"
  Then I should see "Invalid Login"
  Then I should be on the login page

Scenario: navigate to the create user account page
  Given I am on the login page
  When I follow "Create User Account"
  Then I should be on the create user account page

Scenario: login as venue admin with valid account
  Given I am on the login page
  When I choose "type_venue_admin"
  When I fill in "Username" with "amityHall"
  And I fill in "Password" with "password"
  And I press "Login"
  Then I should be on the "amityHall" venue admin dashboard

Scenario: login as venue admin with invalid account stays on login page
  Given I am on the login page
  When I choose "type_venue_admin"
  When I fill in "Username" with "idontexist"
  And I fill in "Password" with "password"
  And I press "Login"
  Then I should see "Invalid Login"
  Then I should be on the login page

Scenario: navigate to the create venue admin account page
  Given I am on the login page
  When I follow "Create Venue Admin Account"
  Then I should be on the create venue admin account page
