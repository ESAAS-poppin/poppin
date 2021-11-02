Feature: Dashboard Page rendering and functionality

  As an existing user of the site
  After I log into my account
  I should see my saved events and venues

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

  And I am logged in to "caseyo"

Scenario: Renders the dashboard page
  Given I am on the "caseyo" dashboard page
  Then I should see "caseyo's Dashboard"
  Then I should see "Your Saved Events"
  Then I should see "Your Favorite Venues"
  Then I should see "Sports Bar"

Scenario: Click to event list
  Given I am on the "caseyo" dashboard page
  When I follow "Search Events"
  Then I should be on the events list page

Scenario: Sign out of my account
  Given I am on the "caseyo" dashboard page
  When I press "Sign Out"
  Then I should be on the login page
  Then I should see "You have signed out"
  
