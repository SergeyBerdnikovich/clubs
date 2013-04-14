class AddColumnsToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :project_name, :string
    add_column :settings, :slogan, :string
  end
end
