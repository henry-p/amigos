class PostsController < ApplicationController

	def index
		@post = Post.all.order('updated_at')
	end

	def show
		@post = Post.find(params[:id])
		if @post.images
			@images = @post.images
		end
	end

	def new
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
		@post = Post.new	
	end


	def create
		user = User.find(params[:user_id])
		post = user.posts.new(post_params)
		post.group_id = params[:group_id]
		image = post.images.new(picture: params[:post][:picture])

		if post.save
			uploader = PictureUploader.new(image)
			uploader.store!(image.picture)
			post.images << image
			raise params
			redirect_to group_user_post_path(params[:group_id],params[:user_id], post.id)
		else
			render 'form'
		end
	end

	def edit	
		@post = Post.find(params[:id])
	end

	def update
		
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end

end
