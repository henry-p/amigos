class PostsController < ApplicationController

	def index
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
		@user_posts = @user.posts
		@posts = Post.all.order('updated_at')
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
		user = User.find(params[:user_id])
		post = user.posts.new(post_params)
		post.group_id = params[:group_id]

		if post.save
			redirect_to group_user_post_path(params[:group_id],params[:user_id], post.id)
		else
			render 'form'
		end
	end

	def edit	
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
		@post = Post.find(params[:id])
	end

	def update
		post = Post.find(params[:id])
		post.update_attributes(post_params)
		redirect_to group_user_post_path(params[:group_id],params[:user_id], post.id)
	end

	def destroy
		Post.destroy(params[:id])
		redirect_to group_user_posts
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end

end
