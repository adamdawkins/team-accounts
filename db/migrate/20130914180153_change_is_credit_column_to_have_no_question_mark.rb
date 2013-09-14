class ChangeIsCreditColumnToHaveNoQuestionMark < ActiveRecord::Migration
  def change
    remove_column :transactions, :is_credit?
    add_column :transactions, :is_credit, :boolean
  end
end
