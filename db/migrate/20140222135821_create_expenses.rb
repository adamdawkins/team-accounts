class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.date :transaction_date
      t.integer :category_id
      t.decimal :amount
      t.string :description

      t.timestamps
    end
  end
end
