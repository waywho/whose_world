class User < ApplicationRecord
	has_secure_password
	validates_uniqueness_of :email

	def to_token_payload
		{
			sub: id,
			admin: admin,
			email: email,
			name: name
		}
	end
end
