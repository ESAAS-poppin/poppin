Given /the following followings exist/ do |followings_table|
  followings_table.hashes.each do |following|
      Following.create following
  end
end

Given /^(?:|I )am on the find friends page$/ do 
  visit users_path
end