require 'spec_helper'

describe ExpensesController do
  describe '#new' do
    before :each do
      controller.stub! :authenticate_user
      get 'new'
    end

    it 'renders the new template' do
      expect(response).to render_template 'new'
    end

    it 'sets the @expense variable to a new Expense model' do
      expect(assigns[:expense]).to_not be_nil
      expect(assigns[:expense].class.name).to eq 'Expense'
    end
  end
end
