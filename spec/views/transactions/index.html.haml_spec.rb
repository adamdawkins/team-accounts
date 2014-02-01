require 'spec_helper'

describe 'transactions/index.html.haml' do
  before :each do
    mock_login
    2.times { FactoryGirl.create(:transaction) }

    visit transactions_path
  end

  it 'displays a table of all transactions' do
    expect(page).to have_selector 'tbody tr', count: Transaction.count
  end

  it "displays an 'add transaction' link" do
    expect(page).to have_selector 'a', text: 'Add transaction'
  end

end
