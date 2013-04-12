class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.text :site_analytics

      t.timestamps
    end
  end
end
