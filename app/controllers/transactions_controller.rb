class TransactionsController < ApplicationController
  before_filter :authenticate_user

  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Transaction.new
  end

  def show
   @transaction = Transaction.find params[:id]
  end
end
