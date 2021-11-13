Given /^I am logged in$/ do
    username = 'testing123'
    password = 'pass123'
    User.new(:username => username, :password => password).save!

    visit '/sessions/new'
    choose('type_user')
    fill_in "user[username]", :with => username
    fill_in "user[password]", :with => password
    click_button "Login"
end

Given /^I am logged in to "([^"]*)"$/ do |user_name|
    user = User.find_by(username: user_name)

    visit '/sessions/new'
    choose('type_user')
    fill_in "user[username]", :with => user.username
    fill_in "user[password]", :with => user.password
    click_button "Login"
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
    click_link(link)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
    if page.respond_to? :should
        page.should have_content(text)
    else
        assert page.has_content?(text)
    end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
    if page.respond_to? :should
        page.should_not have_content(text)
    else
        assert !page.has_content?(text)
    end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
    fill_in(field, :with => value)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
    click_button(button)
end


  