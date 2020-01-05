class Post < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: :slugged
	belongs_to :page
	has_one :feature_image, as: :contentable
	belongs_to :parentable, polymorphic: true
end
