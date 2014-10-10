class SnippetsController < ApplicationController
	def index
		@snippet = Snippet.all.order('updated_at')
	end

	def show
		@snippet = Snippet.find(params[:id])
		if @snippet.images
			@images = @snippet.images
		end
	end

	def new
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
		@snippet = Snippet.new	
	end


	def create
		group = Group.find(params[:group_id])
		user = User.find(params[:user_id])
		snippet = user.snippets.new(snippet_params)
		snippet.group_id = group.id
		image = Snippet.images.new(picture: params[:snippet][:picture])

		if snippet.save
			uploader = PictureUploader.new(image)
			uploader.store!(image.picture)
			snippet.images << image
			redirect_to group_user_snippet_path(params[:group_id],params[:user_id], snippet.id)
		else
			render 'form'
		end
	end

	def edit	
		@snippet = Snippet.find(params[:id])
	end

	def update
		
	end

	def destroy
		@snippet = Snippet.find(params[:id])
		@snippet.destroy
	end

	def snippet_params
		params.require(:snippet).permit(:title, :content)
	end
end
