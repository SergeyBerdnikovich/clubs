class AddParentIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :parent_id, :integer, :default => 0
  end
end
