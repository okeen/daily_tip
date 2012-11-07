@user = User.create email: "user@dailytip.com", password: "aaaaaa", password_confirmation: "aaaaaa"

25.times do |index|
  tip = @user.tips.create title: Faker::Lorem.sentence,
                       content: Faker::Lorem.paragraph(2),
                       tag_list: "tag#{rand(5)},tag#{rand(5)}"
  5.times do |t|
    tip.links.create url: Faker::Internet.url,
                     description: Faker::Lorem.sentence
  end
end