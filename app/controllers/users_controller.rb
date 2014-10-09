class UsersController < ApplicationController

	def index
	end

	def show
		@user = User.second
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(user_params)
		redirect_to user_path
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :current_location)
	end

end
