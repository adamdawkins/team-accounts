require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rspec'

module Helpers
  def login
    user = FactoryGirl.create(:user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'login'
  end
end
