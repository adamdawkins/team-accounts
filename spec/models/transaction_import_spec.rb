require 'spec_helper'

describe TransactionImport do
  let(:valid_csv_file) do
    Rack::Test::UploadedFile.new(
      File.open(File.join(Rails.root, '/spec/fixtures/transactions_upload.csv'))
    )
  end

  context 'with valid transactions' do

    before :each do
      @transaction_import = TransactionImport.new(file: valid_csv_file)
    end

    describe '#process_csv' do
      it 'returns an array of CSV rows' do
        expect(@transaction_import.process_csv).to be_kind_of Array
      end
    end

    describe 'persisted?' do
      it 'returns false' do
        expect(@transaction_import.persisted?).to eq false
      end
    end

    describe 'TransactionImport.build_transaction_from_csv_row' do
      before :each do
        @row = @transaction_import.process_csv.first
      end

      it 'returns a Transaction object'  do
        transaction = TransactionImport.build_transaction_from_csv_row(@row)
        expect(transaction.class.name).to eq 'Transaction'
      end

      context 'When :paid_in is nil' do
        it "sets 'is_credit' to false" do
          @row.delete :paid_in
          @transaction = TransactionImport.build_transaction_from_csv_row(@row)
          expect(@transaction.is_credit?).to eq false

        end
      end

      context 'When :paid_in is not nil' do
        it "sets 'is_credit' to true" do
          @row[:paid_in] = 70.00
          @row.delete :paid_out
          @transaction = TransactionImport.build_transaction_from_csv_row(@row)
          expect(@transaction.is_credit?).to eq true

        end
      end

    end

    describe 'TransactionImport.build_balance_from_csv_row' do
      before :each do
        @row = @transaction_import.process_csv.first
      end

      context 'When :balance does not exist' do
        before :each do
          @row.delete :balance
        end

        it 'returns nil' do
          expect(TransactionImport.build_balance_from_csv_row @row).to be_nil
        end
      end

      context 'When :balance exists' do
        it 'returns a balance object' do
          balance = TransactionImport.build_balance_from_csv_row(@row)
          expect(balance.class.name).to eq 'Balance'
        end

      end
    end

    describe '#imported_transactions' do
      it 'returns an array of Transactions' do
        imported_transactions = @transaction_import.imported_transactions
        expect(imported_transactions).to be_kind_of Array
        expect(imported_transactions.first.class.name).to eq 'Transaction'
      end
    end

    describe '#imported_balances' do
      it 'returns an array of Balances' do
        imported_balances = @transaction_import.imported_balances
        expect(imported_balances).to be_kind_of Array
        expect(imported_balances.first.class.name).to eq 'Balance'
      end
    end

    describe '#save' do
      it 'saves the transactions to the database' do
        expect { @transaction_import.save }.to change(Transaction, :count).by 4
      end

      it 'returns true' do
        expect(@transaction_import.save).to eq true
      end

      it 'saves the balances to the database' do
        expect { @transaction_import.save }.to change(Balance, :count).by 3
      end
    end
  end

  context 'with no file' do

    before :each do
      @transaction_import = TransactionImport.new(file: nil)
    end

    describe '#save' do
      it 'does not save any transactions to the database' do
        expect { @transaction_import.save }.to_not change(Transaction, :count)
      end

      it 'does not save any balances to the database' do
        expect { @transaction_import.save }.to_not change(Balance, :count)
      end
    end

    describe '#process_csv' do
      it 'returns an empty array' do
        expect(@transaction_import.process_csv).to be_kind_of Array
        expect(@transaction_import.process_csv.length).to eq 0
      end
    end
  end

end
