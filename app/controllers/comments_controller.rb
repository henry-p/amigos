class CommentsController < ApplicationController
	before_action :login_required
	before_action :group_user_and_comment_objects
  
	def new
		@comment = Comment.new
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.creator_id = current_user.id
		
		if @post
			@post.comments << @comment
			redirect_to [@group, @post.creator, @post]
		elsif @snippet
			@snippet.comments << @comment
			redirect_to [@group, @snippet.creator, @snippet]
		end
		
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
		@comment.update_attributes(comment_params)
		redirect_to (@post ? [@group, @post.creator, @post] : [@group, @snippet.creator, @snippet])
	end

	def destroy
		@comment.destroy
		redirect_to (@post ? [@group, @post.creator, @post] : [@group, @snippet.creator, @snippet])
	end
	
	def group_user_and_comment_objects
		@comment = Comment.find(params[:id]) unless %w[new create].include?(params[:action])
		params[:snippet_id] ? @snippet = Snippet.find(params[:snippet_id]) : @post = Post.find(params[:post_id])
		@group = Group.find(params[:group_id])
		@post_or_snippet_creator = User.find(params[:user_id])
	end

	def is_creator_of_comment?
		redirect_to [@group, @post_or_snippet_creator, @snippet] unless current_user.id == @comment.creator_id
	end

	def login_required
	  redirect_to new_user_session_path unless current_user
	end
	
	private 
	def comment_params
		params.require(:comment).permit(:content)
	end
end
