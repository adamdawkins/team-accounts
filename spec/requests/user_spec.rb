require 'spec_helper'

describe "Users" do
  describe "GET /users/new" do

    before(:each) do
      mock_login
      visit new_user_path
    end

    describe "the page" do

      it "renders the new user page" do
        expect(page.status_code).to be (200)
      end

      it "prompts to create a new user" do
        expect(page).to have_selector 'h1', text: 'Create user'
      end

      it "has an email input field" do
        expect(page).to have_field 'user[email]'
      end

      it "has a password field" do
        expect(page).to have_field 'user[password]'
      end

      it "has a password confirmation field" do
        expect(page).to have_field 'user[password_confirmation]'
      end

      it "has a create user button" do
        expect(page).to have_button 'Create User'
      end

    end

    context "submit form with valid data" do
      before(:each) do 
        fill_in 'user[email]', with: 'john.smith@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'Create User'
      end

      it  "returns a success message" do
        expect(page).to have_content "Success"
      end

      it "creates a user record in the database" do
        expect(User.where(email: 'john.smith@example.com').length).to eq(1)
      end
    end

    context "submit form with non-matching passwords" do
      before(:each) do 
        fill_in 'user[email]', with: 'john.smith@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'not-the-same-password'
        click_on 'Create User'
      end

      it "displays an error" do
        expect(page).to have_content "error"
      end

      it "does not save a user record in the database" do
        expect(User.where(email: 'john.smith@example.com').length).to eq(0)
      end

      it "remains on the new user page" do
        expect(page.current_path).to eq new_user_path
      end

    end

  end
end
