require "spec_helper"

describe "explainations/_form" do
  before :each do
    transaction = FactoryGirl.create :transaction

    render partial: "explainations/form.html.haml", locals: {explaination: Explaination.new, transaction: transaction}
  end

  it "displays a description field" do
    expect(response).to include "explaination[description]"
  end
  it "displays an amount field" do
    expect(response).to include "explaination[amount]"
  end

  it "has a hidden input with the transaction id in it" do 
    expect(response).to include "explaination[transaction_id]"
  end

  it "displays an 'Add explaination' button" do 
    expect(response).to include "button"
  end

  it "displays a category dropdown" do 
    expect(response).to include "explaination[category_id]"
  end
end
