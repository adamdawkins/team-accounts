require 'spec_helper'

describe TransactionsController do

  let(:test_file) do
    Rack::Test::UploadedFile.new(
      File.open(File.join(Rails.root, '/spec/fixtures/transactions_upload.csv'))
    )
  end

  describe '#new' do
    before :each do
      controller.stub! :authenticate_user
      get 'new'
    end

    it 'renders the new template' do
      expect(response).to render_template 'new'
    end

    it 'sets the @transaction variable' do
      expect(assigns[:transaction]).to_not be_nil
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      before :each do
        controller.stub! :authenticate_user
      end

      it 'creates a new transaction record in the database' do
        expect do
          post :create, transaction: FactoryGirl.attributes_for(:transaction)
        end.to change(Transaction, :count).by(1)
      end

      it 'redirects to the show action' do
        post :create, transaction: FactoryGirl.attributes_for(:transaction)
        expect(response).to redirect_to(Transaction.last)
      end

      it 'sets a success message' do
        post :create, transaction: FactoryGirl.attributes_for(:transaction)
        expect(flash[:success]).to eq 'Transaction created successfully'
      end

      context 'debit transaction' do
        it 'should save with #is_credit set to false' do
          post :create,
               transaction: FactoryGirl.attributes_for(:transaction, :debit)
          expect(Transaction.last.is_credit).to eq false
        end
      end

    end

    context 'with invalid attributes' do
      before :each do
        controller.stub! :authenticate_user
      end
      it 'does not create a transaction' do
        expect do
          post :create,
               transaction: FactoryGirl.attributes_for(:transaction, :invalid)
        end.to_not change(Transaction, :count)
      end

      it 're-renders the new template' do
        post :create,
             transaction: FactoryGirl.attributes_for(:transaction, :invalid)
        expect(response).to redirect_to :new_transaction
      end

      it 'sets an error message' do
        post :create,
             transaction: FactoryGirl.attributes_for(:transaction, :invalid)
        expect(flash[:alert]).to eq 'The transaction was invalid'
      end
    end
  end

  describe '#show' do
    before :each do
      transaction = FactoryGirl.create :transaction
      controller.stub! :authenticate_user
      get 'show', id: transaction.id
    end

    it 'sets the @transaction variable' do
      expect(assigns[:transaction]).to_not be_nil
    end

    it 'renders the show template' do
      expect(response).to render_template 'show'
    end
  end

  describe '#index' do
    before :each do
      controller.stub! :authenticate_user
      2.times do
        FactoryGirl.create(:transaction)
      end
      get 'index'
    end

    it 'assigns the @transactions variable to all transactions' do
      expect(assigns[:transactions]).to_not be_nil
      expect(assigns[:transactions].length).to eq Transaction.all.length
    end

    it 'renders the index template' do
      expect(response).to render_template 'index'
    end
  end

  describe '#import' do
    before :each do
      controller.stub! :authenticate_user
    end

    it 'creates transactions for each transaction in the file' do
      expect do
        post 'import', file: test_file
      end.to change(Transaction, :count).by 3
    end

  end

end
