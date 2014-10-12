class PostsController < ApplicationController

	def index
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
		@user_posts = @user.posts.order('updated_at DESC')
		@posts = Post.all.order('updated_at DESC')
	end

	def show
		@post = Post.find(params[:id])
		@images = @post.images if @post.images != []
		@comments = @post.comments.order('updated_at DESC') if @post.comments != [] 
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
			post.images.create(picture: params[:post][:picture])

			# Send Notification
			GroupMailer.group_post_notifications(post.group, post)

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
		redirect_to group_user_posts_path
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end

end
