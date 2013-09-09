require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    context "user not logged in" do
      before(:each) do
        get 'new'
      end
      it "returns http success" do
        response.should be_success
      end
      
      it "renders the new template" do
        expect(response).to render_template "new"
      end

    end
  end

end
