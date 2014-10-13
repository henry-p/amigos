class PostsController < ApplicationController
	before_action :login_required
	before_action :group_user_and_post_objects

	def index
		@user_posts = @user.posts.order('updated_at DESC')
	end

	def show
		@post = Group.find(params[:group_id]).members.find(params[:user_id]).posts.find(params[:id])
		@images = @post.images if !@post.images.empty?
		@comments = @post.comments.order('updated_at DESC') if !@post.comments.empty?
	end

	def new
		@post = Post.new	
		session[:return_to] = request.referer
	end

	def create
		post = @user.posts.new(post_params)
		post.group_id = @group.id
		pictures = params[:post][:picture]
		if post.save
			pictures.each {|pic| post.images.create(picture: pic)} unless !pictures
			redirect_to session.delete(:return_to)
			# Send Notification
			GroupMailer.group_post_notifications(post.group, post)
		else
			render 'form'
		end
	end

	def edit	
		session[:return_to] = request.referer
		is_current_user?
	end

	def update
		@post.update_attributes(post_params)
		redirect_to session.delete(:return_to)
	end

	def destroy
		@post.destroy
		redirect_to :back
	end

	def group_user_and_post_objects
		@post = Post.find(params[:id]) if %w[edit update destroy].include?(params[:action])
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
	end

	def is_current_user?
		redirect_to redirect_to session.delete(:return_to) unless current_user.id == @user.id
	end

	def login_required
	  redirect_to new_user_session_path unless current_user
	end
	
	private 
		def post_params
			params.require(:post).permit(:title, :content)
		end
end
