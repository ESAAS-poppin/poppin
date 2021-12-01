Feature: Edit Profile Page rendering and functionality

  As an existing user of the site
  After I log into my account
  I be able to update my profile information

Background: users in database
  Given the following users exist:
  | id | username | password | email              | image_url | age |
  | 1  | caseyo   | password | casey@columbia.edu | ''        | 22  |

  Given the following venues exist:
  | id | name         | price_range | venue_type |
  | 10 | Sports Bar   |      $$     |    bar     |
  | 11 | Rooftop Bar  |      $      |    bar     |
  | 12 | Dance Club   |     $$$     |    club    |

  Given the following events exist:
  | id | name            | price_range |     date     | venue_id |
  | 10 | Pitcher Night   |      $$     |   2021-05-25 | 10        |
  | 11 | Happy Hour      |      $      |   2022-06-25 | 11        |
  | 12 | Halloween Party |     $$$     |   2021-10-31 | 12        |

  Given the following saved_venues exist:
  | user_id | venue_id |
  | 1       | 10       |
  | 1       | 11       |

  Given the following saved_events exist:
  | user_id | event_id |
  | 1       | 10       |
  | 1       | 11       |

  And I am logged in to "caseyo"

Scenario: Renders the edit profile page
  Given I am on the "caseyo" edit profile page
  Then I should see "Edit Your Profile Information"

Scenario: Cancel Update Profile
  Given I am on the "caseyo" edit profile page
  When I follow "Cancel"
  Then I should see "caseyo's Dashboard"
  Then I should be on the "caseyo" user dashboard

Scenario: Update Username
  Given I am on the "caseyo" edit profile page
  When I fill in "Username" with "newusername"
  And I press "Update Profile"
  Then I should see "newusername's Dashboard"
