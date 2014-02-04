require 'spec_helper'

describe TransactionImportsController do
  let(:valid_csv_file) do
    Rack::Test::UploadedFile.new(
      File.open(File.join(Rails.root, '/spec/fixtures/transactions_upload.csv'))
    )
  end

  let(:invalid_csv_file) do
    Rack::Test::UploadedFile.new(
      File.open(File.join(Rails.root, '/spec/fixtures/invalid_transactions_upload.csv'))
    )
  end

  describe 'GET new' do
    before :each do
      get 'new'
    end

    it 'assigns @transaction_import to a new TransactionImport' do
      expect(assigns(:transaction_import).class.name).to eq 'TransactionImport'
    end

    it 'renders the new template' do
      expect(response).to render_template 'new'
    end
  end

  describe 'POST create' do
    context 'with valid CSV' do
      before :each do 
        post 'create', transaction_import: {file: valid_csv_file}
      end
      it 'creates transactions for each transaction in the file' do
        expect do
          post 'create', transaction_import: {file: valid_csv_file}
        end.to change(Transaction, :count).by 4
      end
    
      it 'sets the flash success to "Transactions imported successfully"' do
        expect(flash[:success]).to eq 'Transactions imported successfully'
      end

      it 'redirects to the homepage' do 
        expect(response).to redirect_to root_path 
      end

    end

    context 'with invalid CSV' do
      before :each do 
        post 'create', transaction_import: {file: invalid_csv_file}
      end

      it 'does not create any transactions' do
        expect do
          post 'create', transaction_import: {file: invalid_csv_file}
        end.to_not change(Transaction, :count)
      end

      it 'renders the new template' do
        expect(response).to render_template 'new'
      end
    end

  end
end
