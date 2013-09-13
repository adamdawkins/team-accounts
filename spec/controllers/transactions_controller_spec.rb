require 'spec_helper'

describe TransactionsController do

  describe "#new" do 
    before :each do
      controller.stub! :authenticate_user
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
        controller.stub! :authenticate_user
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

    context "with invalid attributes" do 
      before :each do
        controller.stub! :authenticate_user
      end
      it "does not create a transaction" do 
        expect {
          post :create, transaction: FactoryGirl.attributes_for(:transaction, :invalid)
        }.to_not change(Transaction, :count)
      end

      it "re-renders the new template" do
        post :create, transaction: FactoryGirl.attributes_for(:transaction, :invalid)
        expect(response).to redirect_to :new_transaction
      end
    end
  end

  describe "#show" do
    before :each do
      transaction = FactoryGirl.create :transaction
      controller.stub! :authenticate_user
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
      controller.stub! :authenticate_user
      2.times do 
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
