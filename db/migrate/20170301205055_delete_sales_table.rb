class DeleteSalesTable < ActiveRecord::Migration
  def change
  	drop_table "sales"
  end
end
