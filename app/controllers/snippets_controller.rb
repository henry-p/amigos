class SnippetsController < ApplicationController
	before_filter :login_required


	def index
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
		@user_snippets = @user.snippets.order('updated_at DESC')
		@snippets = Snippet.all.order('updated_at DESC')
	end

	def show
		@snippet = Snippet.find(params[:id])
		@image = @snippet.image if !@snippet.image.empty?
		@comments = @snippet.comments.order('updated_at DESC') if !@snippet.comments.empty? 
	end

	def new
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
		@snippet = Snippet.new	
	end


	def create
		user = User.find(params[:user_id])
		snippet = user.snippets.new(snippet_params)
		snippet.group_id = params[:group_id]

		if snippet.save
			snippet.image.create(picture: params[:post][:picture])
			redirect_to group_user_snippet_path(params[:group_id],params[:user_id], snippet.id)
		else
			render 'form'
		end
	end

	def edit	
		@group = Group.find(params[:group_id])
		@snippet = Snippet.find(params[:id])
		@user = User.find(params[:user_id])
	end

	def update
		snippet = Snippet.find(params[:id])
		snippet.update_attributes(snippet_params)
		redirect_to group_user_snippet_path(params[:group_id],params[:user_id], snippet.id)
	end

	def destroy
		Snippet.destroy(params[:id])
		redirect_to group_user_snippets
	end

	private 

	def is_current_user?
		current_user.id == params[:user_id]
	end
	
	def login_required
	  redirect_to new_user_session_path unless current_user
	end

	def snippet_params
		params.require(:snippet).permit(:content)
	end
end
