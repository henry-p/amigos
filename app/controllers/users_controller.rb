class UsersController < ApplicationController

	def index
    
	end

	def show
		@user = User.find(params[:id])
		
	end

	def edit
		@user = User.find(params[:id])
		if @user.image
			@image = @user.image
		else
			@user.image = Image.create
			@image = @user.image
		end
	end

	def update
		@user = User.find(params[:id])
		if params[:user][:picture]
			image = Image.create(picture: params[:user][:picture])
			@user.image = image
			uploader = PictureUploader.new(image)
			uploader.store!(image.picture)
		end
		@user.update_attributes(user_params)
		redirect_to user_path
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :current_location)
	end

end
