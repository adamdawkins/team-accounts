require 'spec_helper'

describe "sessions/new.html.haml" do
  before(:each) do
    visit login_path
  end

  it "has an email input field" do
    expect(page).to have_field 'email'
  end

  it "has a password input field" do
    expect(page).to have_field 'password'
  end

  it "has a login button" do
    expect(page).to have_button 'login'
  end

end
