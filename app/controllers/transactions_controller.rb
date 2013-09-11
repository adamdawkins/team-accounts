class TransactionsController < ApplicationController
  before_filter :authenticate_user

  def index

  end

  def new
    @transaction = Transaction.new

  end
end
