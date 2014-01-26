class RemoveBalanceFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :balance
  end
end
