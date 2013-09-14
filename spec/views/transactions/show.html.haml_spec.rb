require 'spec_helper'

describe "transactions/show.html.haml" do
  describe "displays transaction attributes" do
    before :each do
      @transaction = FactoryGirl.create :transaction
      mock_login
      visit transaction_path @transaction
    end

    it "displays the transaction description" do 
      expect(page).to have_content @transaction.description
    end

    it "displays the transaction amount" do
      expect(page).to have_content @transaction.amount
    end

    it "displays the transaction date" do
      expect(page).to have_content @transaction.date
    end
  end

  context "tranasction without explainations" do
    before :each do
      @transaction = FactoryGirl.create :transaction
      mock_login
      visit transaction_path @transaction
    end

    it "doesn't display an explainations heading" do
      expect(page).to_not have_content "Explainations"
    end
  end

  context "transaction with explainations" do
    before :each do
      mock_login
      @transaction = FactoryGirl.create :transaction
      2.times { FactoryGirl.create :explaination, transaction: @transaction }
      visit transaction_path @transaction
    end

    it "displays an explainations heading" do 
      expect(page).to have_content "Explainations"
    end

    it "displays the explainations" do
      expect(page).to have_selector "#table_explainations tbody tr", count: @transaction.explainations.length
    end
  end
end
