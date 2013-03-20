class Page < ActiveRecord::Base
  attr_accessible :title, :content, :for_top_menu
end
