class Ticket < ActiveRecord::Base
  attr_accessible :is_closed, :title

  has_many :messages
end
