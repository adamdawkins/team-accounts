class TransactionsController < ApplicationController
  before_filter :authenticate_user

  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new transaction_params
    if @transaction.save
      redirect_to @transaction
    end
  end

  def show
   @transaction = Transaction.find params[:id]
  end

  private
  
  def transaction_params
    params.require(:transaction).permit(:date, :description, :amount, :payment_method, :reference)
  end

end
