class AddCategoryIdToExplainations < ActiveRecord::Migration
  def change
    add_column :explainations, :category_id, :integer
  end
end
