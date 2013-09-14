class AddIsCreditColumnToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :is_credit?, :boolean, default: true
  end
end
