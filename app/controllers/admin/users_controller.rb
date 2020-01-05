class Admin::UsersController < ApplicationController
	before_action :authenticate_user
	before_action :authenticate_admin, only: [:index]

	def index
		users = User.all

		render users.to_json(include: [:tenants], except: :password_ingest)
	end

	def create
		user = User.new(user_params)
		if user.save
			render_token_payload(user)
		else
			render json: { errors: [
				{
					 status: '400',
					 title: 'Bad Request',
					 details: user.errors
        		}]
     		}, status: :bad_request
		end
	end

	def destroy
		user = User.new(user_params)
		user.destroy

		render :no_content

	rescue => e
		render json: { errors: [
			details: e.messages
		]}
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
