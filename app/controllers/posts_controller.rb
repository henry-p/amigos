class PostsController < ApplicationController

	def index
		@post = Post.all.order('updated_at')
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
		@post = Post.new	
	end


	def create
		# uploader = PictureUploader.new
		# uploader.store!(params[:post][:picture])
		post = Post.new(post_params)
		image = Image.new(path: params[:post][:picture].path, imageable_type: "post", imageable_id: post.id)

		if post.save
			image.save
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
