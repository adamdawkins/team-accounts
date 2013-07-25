require 'spec_helper'

describe "Users" do
  describe "GET /users/new" do

    before(:each) do
      visit new_user_path
    end

    it "renders the new user page" do
      expect(page.status_code).to be (200)
    end

    it "prompts to create a new user" do
      expect(page).to have_selector 'h1', text: 'Create user'
    end

    it "has an email input field" do
      expect(page).to have_field 'user[email]'
    end

  end
end
