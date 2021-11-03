Feature: Find Friends Page rendering and functionality

  As an existing user of the site
  After I navigate to the Find Friends page
  I should see a list of other users I can potentially follow

Background: users in database
  Given the following users exist:
  | id | username | password | email              | image_url | age |
  | 1  | jorger   | password | jorge@columbia.edu | ''        | 22  |
  | 2  | elies    | password | elie@columbia.edu  | ''        | 24  |
  | 3  | caseyo   | password | casey@columbia.edu | ''        | 22  |
  | 4  | ryank    | password | ryan@columbia.edu  | ''        | 22  |

  Given the following venues exist:
  | id | name         | price_range | venue_type |
  | 10 | Sports Bar   |      $$     |    bar     |
  | 11 | Rooftop Bar  |      $      |    bar     |
  | 12 | Dance Club   |     $$$     |    club    |

  Given the following events exist:
  | id | name            | price_range |     date     | venue_id |
  | 10 | Pitcher Night   |      $$     |   2021-05-25 | 1        |
  | 11 | Happy Hour      |      $      |   2021-06-25 | 2        |
  | 12 | Halloween Party |     $$$     |   2021-10-31 | 3        |

  Given the following saved_venues exist:
  | user_id | venue_id |
  | 1       | 10       |
  | 1       | 11       |

  Given the following saved_events exist:
  | user_id | event_id |
  | 1       | 10       |
  | 1       | 11       |

  Given the following followings exist:
  | user_id | following_user_id |
  | 1       | 2       |
  | 1       | 3       |
  | 1       | 4       |
  | 2       | 3       |
  | 2       | 4       |
  | 3       | 4       |

Scenario: navigate to the Find Friends page from the Dashboard page
  Given I am logged in to "jorger"
  And I am on the "jorger" dashboard page
  When I follow "Find Friends"
  Then I should be on the find friends page

# Scenario: not display the username of the logged in user
#   Given I am logged in to "jorger"
#   And I am on the find friends page
#   And I should not see user 'jorger'

Scenario: see "Unfollow" next to all the users that are followed by the user
  Given I am logged in to "jorger"
  And I am on the find friends page
  Then I should see users 'caseyo', 'elies', 'ryank'
  And I should see 'Unfollow' beside users 'caseyo', 'elies', 'ryank'

Scenario: see "Follow" next to all the users that are not followed by the user
  Given I am logged in to "ryank"
  And I am on the find friends page
  Then I should see users 'caseyo', 'elies', 'jorger'
  And I should see 'Follow' beside users 'caseyo', 'elies', 'jorger'

Scenario: follow a user when "Follow" is pressed
  Given I am logged in to "ryank"
  And I am on the find friends page
  And I press "Follow" on 'jorger'
  Then 'ryank' should follow 'jorger'

Scenario: unfollow a user when "Unfollow" is pressed
  Given I am logged in to "jorger"
  And I am on the find friends page
  And I press "Unfollow" on 'ryank'
  Then 'jorger' should not follow 'ryank'

Scenario: filter users by the text in the search bar
  Given I am logged in to "jorger"
  And I am on the find friends page
  And I fill in "search-text-field" with "elies"
  And I press "Search"
  Then I should see user 'elies'
  And I should not see users 'caseyo', 'ryank'
