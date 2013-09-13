require 'spec_helper'

describe Transaction do
  describe "basic model" do
    it "has a valid factory" do
      expect(FactoryGirl.create(:transaction)).to be_valid
    end

    let(:transaction) {FactoryGirl.build(:transaction)}

    describe "validation" do
      before(:each) do 
        transaction.save!
      end

      it { expect(transaction).to validate_presence_of :date }
      it { expect(transaction).to validate_presence_of :description }
      it { expect(transaction).to validate_presence_of :amount }
      it { expect(transaction).to validate_numericality_of :amount }
    end

    it "saves attributes" do
      result = transaction.save
      expect(result).to be true
    end

    it { should have_many(:explainations).dependent(:destroy) }

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


end
