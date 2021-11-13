Feature: Create Account Page rendering and functionality

  As a new user of the site
  I should be able to create an account

Background: users in database
  Given the following users exist:
  | username | password | email              | image_url | age |
  | caseyo   | password | casey@columbia.edu | ''        | 22  |
  | elies    | password | elie@columbia.edu  | ''        | 24  |
  | jorger   | password | jorge@columbia.edu | ''        | 22  |
  | ryank    | password | ryan@columbia.edu  | ''        | 22  |

Scenario: create a new account
  Given I am on the create user account page
  When I fill in "Username" with "tomf"
  And I fill in "Password" with "password"
  And I fill in "Email" with "new_user@columbia.edu"
  And I fill in "Age" with "22"
  And I press "Create Account"
  Then I should be on the "tomf" user dashboard

Scenario: throw error if user is under 21
  Given I am on the create user account page
  When I fill in "Username" with "temp"
  And I fill in "Password" with "password"
  And I fill in "Email" with "new_user@columbia.edu"
  And I fill in "Age" with "20"
  And I press "Create Account"
  Then I should see "You must be at least 21 to make an account."
  Then I should be on the create user account page

Scenario: throw error if username already exists
  Given I am on the create user account page
  When I fill in "Username" with "caseyo"
  And I fill in "Password" with "password"
  And I fill in "Email" with "caseynew@columbia.edu"
  And I fill in "Age" with "25"
  And I press "Create Account"
  Then I should see "Username already exists, please choose another"
  Then I should be on the create user account page

Scenario: navigate back to the login page
  Given I am on the create user account page
  When I follow "Back to Login"
  Then I should be on the login page