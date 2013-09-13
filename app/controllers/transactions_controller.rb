class TransactionsController < ApplicationController
  before_filter :authenticate_user

  def index
  end

  def new
    @transaction = Transaction.new
  end

  def show
   @transaction = Transaction.find params[:id]
  end
end
