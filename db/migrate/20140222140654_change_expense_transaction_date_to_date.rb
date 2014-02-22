class ChangeExpenseTransactionDateToDate < ActiveRecord::Migration
  def change
    remove_column :expenses, :transaction_date
    add_column :expenses, :date, :date
  end
end
