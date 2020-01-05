class Admin::TenantsController < ApplicationController
	before_action :set_tenant, only: [:show, :update, :destroy]
	before_action :authorise_user
	before_action :authorise_admin, only: [:index]

	# GET /tenants
	def index
		user = User.find(params[:user_id])

		if user.admin?
			@tenants = Tenant.all
			else
			@tenants = user.tenants
		end

		render json: @tenants
	end

	# GET /tenants/1
	def show
		render json: @tenant
	end

	# POST /tenants
	def create
		user = User.find(params[:user_id])

		@tenant = user.tenants.create(tenant_params)

		if @tenant.persisted?
			render json: @tenant, status: :created, location: @tenant
		else
			render json: @tenant.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /tenants/1
	def update
		if @tenant.update(tenant_params)
			render json: @tenant
		else
			render json: @tenant.errors, status: :unprocessable_entity
		end
	end

	# DELETE /tenants/1
	def destroy
		@tenant.destroy
	end

	private
	 # Use callbacks to share common setup or constraints between actions.
	 def set_tenant
	   @tenant = Tenant.find(params[:id])
	 end

	 def authorise_user
	 	user = User.find(params[:user_id])
			if @tenant.user.id != user.id
				render json: { errors: [
				{
					 status: '401',
					 title: 'Unauthorized',
					 details: "You do not have the ability to edit the record"
					}]
				}, status: :unauthorized
			end
	 end

	 # Only allow a trusted parameter "white list" through.
	 def tenant_params
	   params.require(:tenant).permit(:name, :domain, :user)
	 end
end
