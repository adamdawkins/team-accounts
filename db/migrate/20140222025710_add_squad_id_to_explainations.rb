class AddSquadIdToExplainations < ActiveRecord::Migration
  def change
    add_column :explainations, :squad_id, :integer
  end
end
