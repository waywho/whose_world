class Tenant < ApplicationRecord
	after_create :create_apartment
	belongs_to :user
	has_many :menu_items

	def create_apartment
		Apartment::Tenant.create(host)
	end
end
