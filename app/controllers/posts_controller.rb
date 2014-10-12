class PostsController < ApplicationController
	before_action :login_required
	before_action :group_user_and_post

	def index
		@user_posts = @user.posts.order('updated_at DESC')
	end

	def show
		# @post = Group.find(params[:group_id]).members.find(params[:user_id]).posts.find(params[:id])
		@images = @post.images if !@post.images.empty?
		@comments = @post.comments.order('updated_at DESC') if !@post.comments.empty?
	end

	def new
		@post = Post.new	
	end

	def create
		post = @user.posts.new(post_params)
		post.group_id = @group.id
		
		if post.save
			post.images.create(picture: params[:post][:picture])
			redirect_to group_user_post_path(params[:group_id],params[:user_id], post.id)
		else
			render 'form'
		end
	end

	def edit	
		is_current_user?
	end

	def update
		@post.update_attributes(post_params)
		redirect_to group_user_post_path(@group, @user, @post.id)
	end

	def destroy
		@post.destroy
		redirect_to group_user_posts_path
	end

	def group_user_and_post
		@post = Post.find(params[:id]) if %w[show edit update destroy].include?(params[:action])
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
	end

	private 
		def is_current_user?
			redirect_to group_user_posts_path unless current_user.id == @user.id
		end

		def login_required
		  redirect_to new_user_session_path unless current_user
		end

		def post_params
			params.require(:post).permit(:title, :content)
		end
end
