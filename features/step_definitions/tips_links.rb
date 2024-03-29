When /^I can create a new tip with links on it$/ do
  click_link "Post a tip"

  fill_in "Title", with: "A cool tip"

  pending "I have no idea how can the editor be manipulated"
  within_frame 0 do
    #fill_in "tip_content", with: Faker::Lorem.paragraph
    body = page.find "body"

    body.set Faker::Lorem.paragraph
    body.trigger 'keydown'
  end

  step "I can set links on it"
  click_button "Create Tip"
end

Then /^I should see the links on the recently created tip$/ do
  @link_list.each do |link|
    page.should have_selector "a.tip_link", content: link
  end
end

When /^I can set links on it$/ do
  @link_list = %w(
    https://github.com/okeen/daily_tip
    https://github.com/Zorros/Fikket
  )

  click_link "Add Link"

  within( ".fields") do
    fill_in "Url", with: @link_list[0]
  end
end

Given /^some existing tips with links$/ do
  @link = create :link
  @tip = @link.tip
end

When /^I go to the first tip page$/ do
  @tip||= Tip.first
  visit "/tips/#{@tip.id}"
end

When /^I preview the first link$/ do
  Link.any_instance.stubs(:to_readable_article).returns "<p>look at this</p>"
  within ".link" do
    click_link "Preview"
  end
end

Then /^I should see the link page content previewed$/ do
  within ".link_iframe_container" do
    page.should have_selector ".link_close"
    page.should have_content "look at this"
  end
end