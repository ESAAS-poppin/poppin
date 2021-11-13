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

Scenario: login page rendered
  When I go to the login page
  Then I should see "Welcome to Poppin"

Scenario:  login with valid account
  Given I am on the login page
  When I choose "type_user"
  When I fill in "Username" with "caseyo"
  And I fill in "Password" with "password"
  And I press "Login"
  Then I should be on the "caseyo" user dashboard

Scenario: login with invalid account stays on login page
  Given I am on the login page
  When I fill in "Username" with "idontexist"
  And I fill in "Password" with "password"
  And I press "Login"
  Then I should see "Invalid Login"
  Then I should be on the login page

Scenario: navigate to the create account page
  Given I am on the login page
  When I follow "Create User Account"
  Then I should be on the create account page

