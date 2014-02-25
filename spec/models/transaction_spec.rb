require 'spec_helper'

describe Transaction do
  describe 'basic model' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:transaction)).to be_valid
    end

    let(:transaction) { FactoryGirl.build(:transaction) }

    describe 'validation' do
      it { should validate_presence_of :date }
      it { should validate_presence_of :description }
      it { should validate_presence_of :amount }
      it { should validate_numericality_of(:amount).is_greater_than 0.00 }
    end

    describe 'associations' do
      it { should have_many(:explainations).dependent(:destroy) }
      it { should have_many(:categories).through(:explainations) }
    end

  end

  describe 'Transaction.accessible_attributes' do
    it 'returns an array of attributes for use in CSV importer' do
      expect(Transaction.accessible_attributes).to be_kind_of Array
    end

    it "contains 'date'" do
      expect(Transaction.accessible_attributes).to include :date
    end

    it "contains 'description'" do
      expect(Transaction.accessible_attributes).to include :description
    end

    it "contains 'amount'" do
      expect(Transaction.accessible_attributes).to include :amount
    end

  end

  describe '#balance_value' do
    before :all do
      @transaction = FactoryGirl.create :transaction
    end

    it 'returns a string' do
      expect(@transaction.balance_value).to be_kind_of String
    end

    context 'no balance for date' do
      before :all do
        Balance.destroy_all
      end
      it 'returns an empty string' do
        expect(@transaction.balance_value).to eq ''
      end
    end

    context 'with a balance for transaction date' do
      before :all do
        Balance.destroy_all
        @balance = FactoryGirl.create :balance, date: @transaction.date
      end
      it 'returns a format £xx.xx' do
        expect(@transaction.balance_value).to match(/&pound;\d*\.\d\d/)
      end

      it 'returns a value that equals the balance of the tranasction date' do
        expect(
          @transaction.balance_value.delete('&pound;').to_f
        ).to eq @balance.amount.to_f
      end
    end
  end

  describe '#explained_amount' do
    context 'no explainations' do
      before :all do
        @transaction = FactoryGirl.build :transaction
      end

      it 'returns a float' do
        expect(@transaction.explained_amount).to be_kind_of Float
      end

      it 'returns 0.00' do
        expect(@transaction.explained_amount).to eq 0.00
      end

    end

    context 'with explainations' do
      before :all do
        @transaction = FactoryGirl.create :transaction
        2.times do
          FactoryGirl.create :explaination,
                             transaction_id: @transaction.id,
                             amount: 10.00
        end
      end

      it 'returns a float' do
        expect(@transaction.explained_amount).to be_kind_of Float
      end
      it 'returns the sum of the explaination amounts' do
        expect(@transaction.explained_amount).to eq 20.00
      end

    end

  end

  describe '#unexplained_amount' do
    before :all do
      @transaction = FactoryGirl.create :transaction, amount: 100.00
      2.times do
        FactoryGirl.create :explaination,
                           transaction_id: @transaction.id,
                           amount: 10.00
      end
    end
    context 'transaction with explainations' do
      it 'returns a float' do
        expect(@transaction.unexplained_amount).to be_kind_of Float
      end

      it 'equals the transaction amount, less the total of the explainations' do
        expect(@transaction.unexplained_amount).to eq 80.00
      end
    end

    context 'transaction without explainations' do
      before :all do
        @transaction = FactoryGirl.create :transaction
      end

      it 'returns the same value as #amount' do
        expect(@transaction.unexplained_amount).to eq @transaction.amount
      end
    end
  end

  describe '#to_s' do
    before :all do
      @transaction = FactoryGirl.build_stubbed :transaction
    end

    it 'returns the description' do
      expect(@transaction.to_s).to eq @transaction.description
    end
  end

  describe '#value' do
    before :all do
      @transaction = FactoryGirl.build_stubbed :transaction
    end

    it 'returns a float' do
      expect(@transaction.value).to be_kind_of Float
    end

    context 'transaction is credit' do
      before :all do
        @transaction = FactoryGirl.build_stubbed :transaction, :credit
      end

      it 'returns a positive value' do
        expect(@transaction.value).to be > 0.00
      end

      it 'returns the same absolute value as amount' do
        expect(@transaction.value.abs).to eq @transaction.amount
      end

    end

    context 'transaction is debit' do
      before :all do
        @transaction = FactoryGirl.build_stubbed :transaction, :debit
      end

      it 'returns a negative value' do
        expect(@transaction.value).to be < 0.00
      end

      it 'returns the same absolute value as amount' do
        expect(@transaction.value.abs).to eq @transaction.amount
      end

    end
  end

  describe '#display_value' do
    before :all do
      @transaction = FactoryGirl.build_stubbed :transaction
    end

    it 'returns the formatted to currency' do
      expect(@transaction.display_value).to eq(
        number_to_currency @transaction.value
      )
    end

    it 'returns the currency in GBP' do
      expect(@transaction.display_value).to include '&pound;'
    end
  end

  describe '#explained?' do
    it 'returns true when full amount is explained' do
      @transaction = FactoryGirl.create :transaction, amount: 10.00
      FactoryGirl.create :explaination,
                         amount: 10.00,
                         transaction_id: @transaction.id
      expect(@transaction.explained?).to eq true
    end

    it 'returns false when full amount is not explained'  do
      @transaction = FactoryGirl.create :transaction, amount: 10.00
      expect(@transaction.explained?).to eq false
    end
  end

  describe '#label' do
    context 'no explainations' do
      it 'returns the transaction description' do
        transaction = FactoryGirl.build_stubbed :transaction
        expect(transaction.label).to eq transaction.description
      end
    end

    context 'multiple explainations' do
      it "returns 'split transaction'" do
        transaction = FactoryGirl.create :transaction
        2.times do
          FactoryGirl.create :explaination, transaction_id: transaction.id
        end

        expect(transaction.label).to eq 'split transaction'
      end
    end

    context 'one explaination' do
      it 'returns the explaination description' do
        transaction = FactoryGirl.create :transaction
        explaination = FactoryGirl.create :explaination,
                                          transaction_id: transaction.id,
                                          description: 'description'

        expect(transaction.label).to eq explaination.description

      end
    end
  end
end
