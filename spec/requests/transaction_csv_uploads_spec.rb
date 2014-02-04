require 'spec_helper'

describe 'TransactionCsvUploads' do
  describe 'Uploading CSV' do
    context 'transactions page' do
      before :each do
        mock_login
        visit new_transaction_import_path
      end

      it 'has an upload form' do
        expect(page).to have_field 'transaction_import[file]'
      end

      it 'accepts the file upload' do
        file_path = Rails.root + 'spec/fixtures/transactions_upload.csv'
        attach_file('transaction_import[file]', file_path)
        click_button 'Import'

        expect(page).to have_content 'Transactions imported successfully'
      end
    end
  end
  describe 'no CSV uploaded' do
    context 'transactions page' do
      before :each do
        mock_login
        visit new_transaction_import_path
      end

      it 'returns an error message' do
        click_button 'Import'

        expect(page).to have_content 'No CSV found to upload'
      end
    end
  end
end
