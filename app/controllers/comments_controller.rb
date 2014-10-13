class CommentsController < ApplicationController
	before_action :login_required
	before_action :group_user_and_comment_objects
  
	def new
		@comment = Comment.new
		session[:return_to] = request.referer
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.creator_id = current_user.id
		
		if @post
			@post.comments << @comment
		elsif @snippet
			@snippet.comments << @comment
		end
		
		redirect_to session.delete(:return_to)
	end

	def edit
		@comment = Comment.find(params[:id])
		session[:return_to] = request.referer
	end

	def update            
		@comment = Comment.find(params[:id])
		@comment.update_attributes(comment_params)
		redirect_to session.delete(:return_to)
	end

	def destroy
		@comment.destroy
		redirect_to :back 
	end
	
	def group_user_and_comment_objects
		@comment = Comment.find(params[:id]) unless %w[new create].include?(params[:action])
		params[:snippet_id] ? @snippet = Snippet.find(params[:snippet_id]) : @post = Post.find(params[:post_id])
		@group = Group.find(params[:group_id])
		@post_or_snippet_creator = User.find(params[:user_id])
	end

	def login_required
	  redirect_to new_user_session_path unless current_user
	end
	
	private 
	def comment_params
		params.require(:comment).permit(:content)
	end
end
