class TransactionImportsController < ApplicationController
  def new
    @transaction_import = TransactionImport.new
  end

  def create
    @transaction_import = TransactionImport.new params[:transaction_import]
    if @transaction_import.save
      flash[:success] = 'Transactions imported successfully'
      redirect_to root_path
    else
      flash[:error] = 'No CSV found to upload' unless @transaction_import.file
      render :new
    end
  end
end
