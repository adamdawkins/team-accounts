class TransactionImportsController < ApplicationController
  def new
    @transaction_import = TransactionImport.new
  end

  def create
    @transaction_import = TransactionImport.new params[:transaction_import]
    if @transaction_import.file
      if @transaction_import.save
        flash[:success] = 'Transactions imported successfully'
        redirect_to root_path
      else
        render :new
      end
    else
      flash[:error] = 'No CSV found to upload'
      render :new
    end
  end

  private

end
