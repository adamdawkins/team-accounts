class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.date    :date
      t.decimal :amount

      t.timestamps
    end
  end
end
