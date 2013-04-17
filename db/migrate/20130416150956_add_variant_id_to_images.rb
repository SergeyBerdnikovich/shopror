class AddVariantIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :variant_id, :integer
  end
end
