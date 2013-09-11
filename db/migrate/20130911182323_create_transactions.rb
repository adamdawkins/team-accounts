class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :description
      t.date :date
      t.decimal :amount
      t.string :payment_method
      t.string :reference

      t.timestamps
    end
  end
end
