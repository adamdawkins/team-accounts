require 'spec_helper'

describe "TransactionCsvUploads" do
  describe "uploading CSV" do
    context "transactions page" do
      before :each do
        mock_login
        visit transactions_path
      end

      it "has an upload form" do
        expect(page).to have_field "file"
      end

      it "accepts the file upload" do
        file_path = Rails.root + 'spec/fixtures/transactions_upload.csv'
        attach_file('file', file_path)
        click_button "Import"

        expect(page).to have_content "Transactions imported successfully"
      end
    end 
  end
end
