require 'spec_helper'

describe "transactions/index.html.haml" do
  before :each do
    mock_login

    # create a random number of transactions
    random = Random.new
    random.rand(5..15).times do 
      FactoryGirl.create(:transaction)
    end 

    visit transactions_path
  end

  it "displays a table of all transactions" do
    expect(page).to have_selector 'tbody tr', count: Transaction.all.length
  end



  it "displays an 'add transaction' link" do
    expect(page).to have_selector 'a', text: "Add transaction"
  end
end
