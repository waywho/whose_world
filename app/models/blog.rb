class Blog < ApplicationRecord
	has_many :posts, as: :parentable
	has_many :menu_itmes, as: :navigation
end
