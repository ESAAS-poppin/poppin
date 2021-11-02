Given /the following followings exist/ do |followings_table|
  followings_table.hashes.each do |following|
      Following.create following
  end
end

Given /^(?:|I )am on the find friends page$/ do 
  visit users_path
end

When /^(?:|I )press "([^"]*)" on '(.*)'$/ do |button, user|
    page.find('td', text: user).click_button(button)
end

Then /^I should be on the find friends page$/ do
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == users_path
  else
    assert_equal users_path, current_path
  end
end

Then /^I should( not)? see user(?:s)? '(.*)'$/ do |should_see, users|
  users.split("', '").each do |user|
    step %{I should#{should_see} see "#{user}"}
  end
end

Then /^I should see '((?:Un)?[F|f]ollow)' beside user(?:s)? '(.*)'$/ do |should_see_follow, users|
  users.split("', '").each do |user|
    element = page.find('td', text: user)
    expect(element).to have_button(should_see_follow)
  end
end

Then /^'(.*)' should( not)? follow '(.*)'$/ do |user_a, should_not_follow, user_b|
  id_a = User.find_by_username(user_a)
  id_b = User.find_by_username(user_b)
  follows = Following.find_by(user_id: id_a, following_user_id: id_b)
  if should_not_follow
    expect(follows).to be_nil
  else
    expect(follows).to be
  end
  
end