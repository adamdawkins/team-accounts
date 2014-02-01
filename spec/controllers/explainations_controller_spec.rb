require 'spec_helper'

describe ExplainationsController do

  describe '#create' do
    before :each do
      controller.stub! :authenticate_user
      @transaction = FactoryGirl.create :transaction
      @category = FactoryGirl.create :category
    end

    it 'creates a new explaination record in the database' do
      expect do
        post :create, explaination:
          FactoryGirl.attributes_for(:explaination,
                                     transaction_id: @transaction.id,
                                     category_id: @category.id
                                    )
      end.to change(Explaination, :count).by(1)
    end

    context 'with valid attributes' do
      before :each do
        post :create, explaination:
          FactoryGirl.attributes_for(
            :explaination,
            transaction_id: @transaction.id,
            category_id: @category.id
        )
      end

      it 'assigns the @explaination variable' do
        expect(assigns[:explaination]).to_not be_nil
      end

      it 'redirects to the show action for the transaction' do
        expect(response).to redirect_to(Explaination.last.transaction)
      end

      it 'sets a success message' do
        expect(flash[:success]).to eq 'Explaination added successfully'
      end
    end

    context 'with invalid attributes' do
      before :each do
        controller.stub! :authenticate_user
      end
      it 'does not create an explaination' do
        expect do
          post :create, explaination: FactoryGirl.attributes_for(:explaination,
                                                                 :invalid)
        end.to_not change(Explaination, :count)
      end

      it 'sets an error message' do
        post :create, explaination: FactoryGirl.attributes_for(:explaination,
                                                               :invalid)
        expect(flash[:alert]).to eq 'The explaination was invalid'
      end
    end
  end
end
