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


  context "transaction with unexplained amount" do 
    before :each do
      mock_login
      @transaction = FactoryGirl.create :transaction 
      visit transaction_path @transaction 
    end
    
    it "displays the unexplained amount" do
      expect(page).to have_content "Unexplained:"
    end 

    it "displays the new explaination form" do
     expect(page).to have_selector "#new_explaination_form"
    end
  end

  context "transaction with no unexplained amount" do 
    before :each do
      mock_login
      @transaction = FactoryGirl.create :transaction, amount: 10.00
      FactoryGirl.create :explaination, amount: 10.00, transaction_id: @transaction.id
      visit transaction_path @transaction 
    end

    it "displays text saying transaction is explained" do
      expect(page).to have_content "Transaction explained"
    end

    it "does not display the new explaination form" do
     expect(page).to_not have_selector "#new_explaination_form"
    end
  end
end
