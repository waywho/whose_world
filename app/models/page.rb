class Page < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: :slugged

	has_one :feature_image, as: :contentable
	has_many :posts, as: :parentable
	has_many :menu_itmes, as: :navigation
end
