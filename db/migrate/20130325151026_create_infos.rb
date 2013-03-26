class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :telephone_number
      t.integer :order_id
      t.string :payment_method

      t.timestamps
    end
  end
end
