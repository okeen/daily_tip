When /^I give the tip an "([^"]*)" vote$/ do |vote|
  link = vote == "up" ? "Good" : "Bad"
  within "#tip_votes" do
    click_button link
  end
end

Then /^I should see the tip with no vote yet$/ do
  within "#tip_votes" do
    page.should have_selector "button.popularity_negative"
    page.should have_selector "button.popularity_positive"

    page.should_not have_selector "button.popularity_negative.active"
    page.should_not have_selector "button.popularity_positive.active"
  end
end

Then /^I should see the tip as "([^"]*)" voted from me$/ do |vote|
  within "#tip_votes" do
    if vote == "up"
      page.should_not have_selector "button.popularity_negative.active"
      page.should have_selector "button.popularity_positive.active"
    else
      page.should have_selector "button.popularity_negative.active"
      page.should_not have_selector "button.popularity_positive.active"
    end
  end
end

def positive_evaluation(tip, user)
  tip.add_or_update_evaluation(:votes, 1, user)
end

def negative_evaluation(tip, user)
  tip.add_or_update_evaluation(:votes, -1, user)
end


When /^some existing tips with votes$/ do
  @tips = create_list :tip, 5
  @users = User.all

  # +1 -1 = 0
  positive_evaluation(@tips[0], @users[0])
  negative_evaluation(@tips[0], @users[1])

  # +1 +1 = 2
  positive_evaluation(@tips[1], @users[0])
  positive_evaluation(@tips[1], @users[1])

  # +1 +1 +1 = 3
  positive_evaluation(@tips[2], @users[0])
  positive_evaluation(@tips[2], @users[1])
  positive_evaluation(@tips[2], @users[2])

  # -1 -1 = -2
  negative_evaluation(@tips[3], @users[0])
  negative_evaluation(@tips[3], @users[1])

  positive_evaluation(@tips[4], @users[1])

end

When /^I sort the tips by popularity$/ do
  visit "/tips"
  click_link "Popular"
end

Then /^I can see the tips ordered by popularity$/ do
  # [id, votes] =  [[1, 0.0], [2, 2.0], [3, 3.0], [4, -2.0], [5, 1.0]]
  within "#tips" do
    page.should have_selector "#tip_#{@tips[2].id}.tip[1]", content: @tips[2].title
    page.should have_selector "#tip_#{@tips[1].id}.tip[2]", content: @tips[1].title
    page.should have_selector "#tip_#{@tips[4].id}.tip[3]", content: @tips[4].title
    page.should have_selector "#tip_#{@tips[0].id}.tip[4]", content: @tips[0].title
    page.should have_selector "#tip_#{@tips[3].id}.tip[5]", content: @tips[3].title
  end
end
