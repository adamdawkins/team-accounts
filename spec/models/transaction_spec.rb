require 'spec_helper'

describe Transaction do
  describe "basic model" do
    it "has a valid factory" do
      expect(FactoryGirl.create(:transaction)).to be_valid
    end

    let(:transaction) {FactoryGirl.build(:transaction)}

    describe "validation" do

      it { should validate_presence_of :date }
      it { should validate_presence_of :description }
      it { should validate_presence_of :amount }
      it { should validate_numericality_of(:amount).is_greater_than 0.00 }
    end
    
   describe "associations" do 
    it { should have_many(:explainations).dependent(:destroy) }
   end

  end

  describe "#explained_amount" do
    context "no explainations" do
      before :all do 
        @transaction = FactoryGirl.build :transaction
      end


      it "returns a float" do
        expect(@transaction.explained_amount).to be_kind_of Float
      end

      it "returns 0.00" do
        expect(@transaction.explained_amount).to eq 0.00
      end

    end

    context "with explainations" do
      before :all do
        @transaction = FactoryGirl.create :transaction
        2.times {
          FactoryGirl.create :explaination,
          transaction_id: @transaction.id,
          amount: 10.00
        }
      end

      it "returns a float" do 
        expect(@transaction.explained_amount).to be_kind_of Float
      end
      it "returns the sum of the explaination amounts" do 
        expect(@transaction.explained_amount).to eq 20.00
      end

    end
    


  end

  describe "#unexplained_amount" do 
    before :all do
      @transaction = FactoryGirl.create :transaction, amount: 100.00
      2.times {
        FactoryGirl.create :explaination,
                            transaction_id: @transaction.id,
                            amount: 10.00
      }
    end
    context "transaction with explainations" do
      it "returns a float" do
        expect(@transaction.unexplained_amount).to be_kind_of Float
      end 

      it "equals the transaction amount, less the total of the explainations" do
        expect(@transaction.unexplained_amount).to eq 80.00
      end
    end

    context "transaction without explainations" do
      before :all do
        @transaction = FactoryGirl.create :transaction
      end

      it "returns the same value as #amount" do
        expect(@transaction.unexplained_amount).to eq @transaction.amount
      end
    end
  end

  describe "#to_s" do
    before :all do
      @transaction = FactoryGirl.build_stubbed :transaction
    end

    it "returns the description" do
      expect(@transaction.to_s).to eq @transaction.description
    end
  end

  describe "#value" do 
    before :all do
      @transaction = FactoryGirl.build_stubbed :transaction
    end

    it "returns a float" do 
      expect(@transaction.value).to be_kind_of Float
    end

    context "transaction is credit" do
      before :all do
        @transaction = FactoryGirl.build_stubbed :transaction, :credit
      end

      it "returns a positive value" do 
        expect(@transaction.value).to be > 0.00
      end

    it "returns the same absolute value as amount" do
      expect(@transaction.value.abs).to eq @transaction.amount
    end

    end

    context "transaction is debit" do
      before :all do
        @transaction = FactoryGirl.build_stubbed :transaction, :debit
      end

      it "returns a negative value" do 
        expect(@transaction.value).to be < 0.00
      end

      it "returns the same absolute value as amount" do
        expect(@transaction.value.abs).to eq @transaction.amount
      end

    end
  end

  describe "#display_value" do 
    before :all do
      @transaction = FactoryGirl.build_stubbed :transaction
    end
    
    it "returns the formatted to currency" do 
      expect(@transaction.display_value).to eq number_to_currency @transaction.value
    end

    it "returns the currency in GBP" do 
      expect(@transaction.display_value).to include "&pound;"
    end
  end

  describe "#explained?" do
      it "returns true when full amount is explained" do
        @transaction = FactoryGirl.create :transaction, amount: 10.00
        FactoryGirl.create :explaination, amount: 10.00, transaction_id: @transaction.id
        expect(@transaction.explained?).to eq true
      end

      it "returns false when full amount is not explained"  do
        @transaction = FactoryGirl.create :transaction, amount: 10.00
        expect(@transaction.explained?).to eq false
      end
    end

end
