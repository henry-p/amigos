class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
    
	end

	def show
		@user = User.find(params[:id])
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
		params.require(:user).permit(:first_name, :last_name, :current_location)
	end

end
