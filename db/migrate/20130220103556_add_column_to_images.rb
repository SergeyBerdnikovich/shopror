class AddColumnToImages < ActiveRecord::Migration
  def change
    add_column :images, :for_slider, :boolean
  end
end
