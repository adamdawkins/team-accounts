require 'spec_helper'

describe "transactions/show.html.haml" do
  before :each do
    @transaction = FactoryGirl.create :transaction
    mock_login
    visit transaction_path @transaction
  end

  it "displays the transaction description" do 
    expect(page).to have_content @transaction.description
  end

  it "displays the transaction amount"
  it "displays the transaction date"

  context "transaction has explainations" do
    it "displays the explainations"

    context "the transaction has an unexplained amount" do
      it "displays the new explaination form" 
    end

  end

end
