class Message < ActiveRecord::Base
  attr_accessible :from_user_id, :is_read, :text, :to_user_id, :ticket_id, :ticket_attributes
  belongs_to :from_user, :class_name => 'User'
  belongs_to :to_user, class_name: 'User'
  belongs_to :ticket

  scope :get_count_new_messages, ->(to_user_id) { where("to_user_id = ? AND is_read = 'f'", to_user_id) }
  scope :get_dialog_messages, ->(from_user_id, to_user_id, ticket_id) {
    where("from_user_id = ? AND to_user_id = ? AND ticket_id = ?", from_user_id, to_user_id, ticket_id) +
    where("from_user_id = ? AND to_user_id = ? AND ticket_id = ?", to_user_id, from_user_id, ticket_id) }
  scope :get_rcvd_messages, ->(to_user_id) { where("to_user_id = ?", to_user_id) }

  accepts_nested_attributes_for :ticket,
                                :allow_destroy => :true,
                                :reject_if => :all_blank
end
