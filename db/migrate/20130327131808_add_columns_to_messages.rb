class AddColumnsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :ticket_id, :integer
  end
end
