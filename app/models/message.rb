class Message < ActiveRecord::Base
  attr_accessible :from_user_id, :is_read, :text, :to_user_id
  belongs_to :from_user, :class_name => 'User'
  belongs_to :to_user, class_name: 'User'

  scope :get_count_new_messages, ->(to_user_id) { where("to_user_id = ? AND is_read = 'f'", to_user_id) }
  scope :get_dialog_messages, ->(from_user_id, to_user_id) {
    where("from_user_id = ? AND to_user_id = ?", from_user_id, to_user_id) +
    where("from_user_id = ? AND to_user_id = ?", to_user_id, from_user_id ) }
  scope :get_rcvd_messages, ->(to_user_id) { where("to_user_id = ?", to_user_id) }
end
