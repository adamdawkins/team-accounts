class TransactionsController < ApplicationController
  before_filter :authenticate_user

  def index
    @transactions = Transaction.order "date DESC"
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new transaction_params
    if @transaction.save
      flash[:success] = "Transaction created successfully"
      redirect_to @transaction
    else
      flash[:alert] = "The transaction was invalid"
      redirect_to new_transaction_path
    end
  end

  def show
   @transaction = Transaction.find params[:id]
  end

  def import
    Transaction.import params[:file]
    redirect_to transactions_path, notice: "Transactions imported successfully"
  end

  private
  
  def transaction_params
    params.require(:transaction).permit(:date, :description, :amount, :payment_method, :reference, :is_credit)
  end

end
