require 'spec_helper'

describe TransactionsController do

  describe "#new" do 
    before :each do
      session[:user_id] = FactoryGirl.create(:user).id
      get 'new'
    end

    it "renders the new template" do 
      expect(response).to render_template 'new'
    end

    it "sets the @transaction variable" do
      expect(assigns[:transaction]).to_not be_nil
    end
  end

end