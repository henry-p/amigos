class UsersController < ApplicationController

	def index
	end

	def show
		@user = User.second
	end

end
