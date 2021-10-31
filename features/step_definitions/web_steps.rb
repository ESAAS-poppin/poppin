Given /^I am logged in$/ do
    username = 'testing123'
    password = 'pass123'
    User.new(:username => username, :password => password).save!

    visit '/sessions/new'
    fill_in "user[username]", :with => username
    fill_in "user[password]", :with => password
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