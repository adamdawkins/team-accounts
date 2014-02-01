require 'spec_helper'

describe "transactions/new.html.haml" do
  before :each do
    mock_login
    visit new_transaction_path
  end

  it "displays a new transaction title" do
    expect(page).to have_selector "h1", text: "New Transaction"
  end

  it "displays a description field" do
    expect(page).to have_field "transaction[description]"
  end

  it "displays an amount field" do
    expect(page).to have_field "transaction[amount]", type: "number"
  end

  it "displays is_credit radio buttons" do
    expect(page).to have_field "transaction[is_credit]", type: "radio"
  end
  it "displays a date field" do
    expect(page).to have_field "transaction[date]"
  end

  it "displays an add transaction button" do
    expect(page).to have_button "Create transaction"
  end

end
