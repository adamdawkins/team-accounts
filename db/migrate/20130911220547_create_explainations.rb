class CreateExplainations < ActiveRecord::Migration
  def change
    create_table :explainations do |t|
      t.string :description
      t.decimal :amount
      t.integer :transaction_id

      t.timestamps
    end
  end
end
