require 'spec_helper'

describe TransactionImport do
  let(:test_file) { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/transactions_upload.csv'))) }

  before :each do
    @transaction_import = TransactionImport.new(file: test_file)
  end

  describe "#process_csv" do
    it "returns an array of CSV rows" do
      expect(@transaction_import.process_csv).to be_kind_of Array
    end
  end

  context "with valid transactions" do

    describe "TransactionImport.build_transaction_from_csv_row" do
      before :each do
        @row = @transaction_import.process_csv.first
      end

      it "returns a Transaction object"  do
        expect(TransactionImport.build_transaction_from_csv_row(@row).class.name).to eq "Transaction"
      end

      context "When :paid_in is nil" do
        it "sets 'is_credit' to false" do
          @row.delete :paid_in
          @transaction = TransactionImport.build_transaction_from_csv_row(@row)
          expect(@transaction.is_credit?).to eq false

        end
      end

      context "When :paid_in is not nil" do
        it "sets 'is_credit' to true" do
          @row[:paid_in] = 70.00
          @row.delete :paid_out
          @transaction = TransactionImport.build_transaction_from_csv_row(@row)
          expect(@transaction.is_credit?).to eq true

        end
      end

    end

    describe "TransactionImport.build_balance_from_csv_row" do
      before :each do
        @row = @transaction_import.process_csv.first
      end

      context "When :balance does not exist" do
        before :each do
          @row.delete :balance
        end

        it "returns nil" do
          expect(TransactionImport.build_balance_from_csv_row @row).to be_nil
        end
      end

      context "When :balance exists" do
        it "returns a balance object" do
          expect(TransactionImport.build_balance_from_csv_row(@row).class.name).to eq 'Balance'
        end

      end
    end

    describe "#imported_transactions" do
      it "returns an array of Transactions" do
        expect(@transaction_import.imported_transactions).to be_kind_of Array
        expect(@transaction_import.imported_transactions.first.class.name).to eq "Transaction"
      end
    end

    describe "#imported_balances" do
      it "returns an array of Balances" do
        expect(@transaction_import.imported_balances).to be_kind_of Array
        expect(@transaction_import.imported_balances.first.class.name).to eq "Balance"
      end
    end

    describe "#save" do
      it "saves the transactions to the database" do
        expect { @transaction_import.save }.to change(Transaction, :count).by 4
      end

      it "returns true" do
        expect(@transaction_import.save).to eq true
      end

      it "saves the balances to the database" do
        expect { @transaction_import.save }.to change(Balance, :count).by 3
      end
    end
  end
end
