class TenantsController < ActionController::Base
	skip_before_action :verify_authenticity_token
   protect_from_forgery prepend: true, with: :exception
	layout 'application'
	
	def index
	end
end