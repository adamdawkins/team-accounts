require 'spec_helper'

describe 'Transactions' do

  describe 'GET /transactions' do
    context 'user logged in' do

      before :each do
        mock_login
        visit transactions_path
      end

      it 'loads the transactions path' do
        expect(page.current_path).to eq transactions_path
      end

    end

    context 'user not logged in' do

      it 'redirects to the login page' do
        visit transactions_path
        expect(page.current_path).to eq login_path
      end

    end
  end

  describe 'GET /transactions/new' do

    context 'user not logged in' do

      it 'redirects to the login page' do
        visit new_transaction_path
        expect(page.current_path).to eq login_path
      end

    end

    context 'user logged in' do

      before :each do
        mock_login
        visit new_transaction_path
      end

      it 'loads the new transaction page' do
        expect(page.current_path).to eq new_transaction_path
        expect(page.status_code).to eq 200
      end

    end
  end

  describe 'GET /transactions/new' do

    context 'user not logged in' do

      it 'redirects to the login page' do
        visit new_transaction_path
        expect(page.current_path).to eq login_path
      end

    end

    context 'user logged in' do

      before :each do
        mock_login
        visit new_transaction_path
      end

      it 'loads the new transaction page' do
        expect(page.current_path).to eq new_transaction_path
        expect(page.status_code).to eq 200
      end

    end
  end

  describe 'POST /transactions' do
    context 'valid transaction' do
      before :each do
        @transaction = FactoryGirl.build :transaction
        mock_login
        visit new_transaction_path
        fill_in 'transaction[date]', with: @transaction.date
        fill_in 'transaction[amount]', with: @transaction.amount
        fill_in 'transaction[description]', with: @transaction.description
        click_button 'Create transaction'
      end

      it 'saves the transaction record' do
        expect(page.current_path).to_not eq new_transaction_path
        expect(page).to have_content 'Transaction created successfully'
      end

    end
  end

  describe 'GET /transactions/show/1' do
    context 'user not logged in' do

      it 'redirects to the login page' do
        @transaction = FactoryGirl.create :transaction
        visit transaction_path @transaction
        expect(page.current_path).to eq login_path
      end

    end

    context  'user logged in' do
      before :all do
        mock_login
        @transaction = FactoryGirl.create :transaction
      end

      before :each do
        visit transaction_path @transaction
      end

      it 'loads the show transaction page' do
        expect(page.current_path).to eq transaction_path @transaction
        expect(page.status_code).to eq 200
      end
    end
  end

end
