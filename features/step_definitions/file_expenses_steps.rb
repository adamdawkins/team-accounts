Given(/^I am logged in$/) do
  @user = FactoryGirl.create :user
  visit root_path
  fill_in 'email', with: @user.email
  fill_in 'password', with: @user.password
end

When(/^I visit "(.*?)"$/) do |url|
  visit "http://localhost:3000#{url}"
end

Then(/^I should see a (.*?)$/) do |element|
  expect(page).to have_selector element
end

When(/^I file an expense with value £(\d+)\.(\d+) and description "(.*?)"$/) do
  |pounds, pence, description|
  fill_in 'Amount', with: "#{pounds}.#{pence}"
  fill_in 'Description', with: description
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content content
end
