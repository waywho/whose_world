class Admin::UsersController < ApplicationController

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

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
