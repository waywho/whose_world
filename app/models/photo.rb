class Photo < ApplicationRecord
	belongs_to :contentable, polymorphic: true
end
