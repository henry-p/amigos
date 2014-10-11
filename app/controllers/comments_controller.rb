class CommentsController < ApplicationController

	
	def new
		@comment = Comment.new
		@group = Group.find(params[:group_id])
		@post_or_snippet_creator = User.find(params[:user_id])
		if params[:post_id]
			@post = Post.find(params[:post_id]) 
		elsif params[:snippet_id]
			@snippet = Snippet.find(params[:snippet_id])
		end
	end

	def create
		
		group = Group.find(params[:group_id])
		post_or_snippet_creator = User.find(params[:user_id])
		comment = Comment.new(comment_params)
		comment.creator_id = current_user.id
		
		if params[:post_id]
			post = Post.find(params[:post_id])
			post.comments << comment
			redirect_to [group, post_or_snippet_creator, post]
		elsif params[:snippet_id]
			snippet = Snippet.find(params[:snippet_id])
			snippet.comments << comment
			redirect_to [group, post_or_snippet_creator, snippet]
		end
		
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comment = Comment.find(params[:id])
	end

	def comment_params
		params.require(:comment).permit(:content)
	end
end
