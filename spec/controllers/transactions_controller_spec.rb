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

  describe "#create" do
    context "with valid attributes" do
      before :each do 
        session[:user_id] = FactoryGirl.create(:user).id
      end

      it "creates a new transaction record in the database" do
        expect {
          post :create, transaction: FactoryGirl.attributes_for(:transaction)
        }.to change(Transaction, :count).by(1)
      end
      
      it "redirects to the show action" do
          post :create, transaction: FactoryGirl.attributes_for(:transaction)
          expect(response).to redirect_to(Transaction.last)
      end

    end
  end

  describe "#show" do
    before :each do
      transaction = FactoryGirl.create :transaction
      session[:user_id] = FactoryGirl.create(:user).id
      get 'show', id: transaction.id
    end

    it "sets the @transaction variable" do 
      expect(assigns[:transaction]).to_not be_nil
    end

    it "renders the show template" do
      expect(response).to render_template 'show'
    end
  end

  describe "#index" do
    before :each do 
      session[:user_id] = FactoryGirl.create(:user).id
      random = Random.new
      random.rand(5..15).times do 
        FactoryGirl.create(:transaction)
      end 
      get 'index'
    end

    it "assigns the @transactions variable to all transactions" do
      expect(assigns[:transactions]).to_not be_nil
      expect(assigns[:transactions].length).to eq Transaction.all.length
    end

    it "renders the index template" do
      expect(response).to render_template 'index'
    end
  end

end
