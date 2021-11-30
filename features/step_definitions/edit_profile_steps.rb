Given /^(?:|I )am on the "([^"]*)" edit profile page$/ do |user_name|
    user = User.where(username: user_name).first
    user_id = user.id
    visit edit_user_path(user_id)
end