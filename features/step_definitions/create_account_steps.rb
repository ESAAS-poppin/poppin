
Given /^(?:|I )am on the create account page$/ do 
    visit new_user_path
end

Then /I should be on the create account page$/ do
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
      current_path.should == new_user_path
    else
      assert_equal new_user_path, current_path
    end
end
