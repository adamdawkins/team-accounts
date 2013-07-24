require 'spec_helper'

describe "Home Page" do
  describe "GET /" do

    context "empty database" do

      before(:each) do
        visit "/"
      end

      it "renders" do
        expect(page.status_code).to be (200)
      end

      it "displays a login prompt" do
        pending 'requires users, and more logic'
        expect(page).to have_selector 'h1', text:'Login'
      end

      it "displays a title" do
        expect(page).to have_selector 'h1#title', text:'Team Budget'
      end

    end

  end
end
