class ExplainationsController < ApplicationController
  def create
    @explaination = Explaination.new explaination_params
    if @explaination.save
      flash[:success] = 'Explaination added successfully'
    else
      flash[:alert] = 'The explaination was invalid'
    end
    redirect_to transaction_path explaination_params[:transaction_id]
  end

  private

  def explaination_params
    params.require(:explaination).permit(
      :date,
      :description,
      :amount,
      :is_credit,
      :transaction_id,
      :category_id,
      :squad_id
    )
  end
end
