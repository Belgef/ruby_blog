class AddColumnsToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :category_id, :string
    add_column :articles, :—force, :string
  end
end
