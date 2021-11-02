Given /the following followings exist/ do |followings_table|
  followings_table.hashes.each do |following|
      Following.create following
  end
end

Given /^(?:|I )am on the find friends page$/ do 
  visit users_path
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

Then /^I should see '((?:Un)?Follow)' beside user(?:s)? '(.*)'$/ do |should_see_follow, users|
  users.split("', '").each do |user|
    element = page.find('td', text: user).find('input', should_see_follow)
    byebug
    # step %{I should#{should_see} see "#{user}"}
  end
end