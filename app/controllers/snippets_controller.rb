class SnippetsController < ApplicationController
	before_action :login_required
	before_action :group_user_and_snippet_objects

	def index
		@user_snippets = @user.snippets.order('updated_at DESC')
	end

	def show
		@snippet = @group.members.find(@user.id).snippets.find(@snippet.id)
		@image = @snippet.image.first if !@snippet.image.empty?
		@comments = @snippet.comments.order('updated_at DESC') if !@snippet.comments.empty? 
	end

	def new
		@snippet = Snippet.new	
		session[:return_to] = request.referer
	end

	def create
		snippet = @user.snippets.new(snippet_params)
		snippet.group_id = @group.id
		picture = params[:snippet][:picture]
		if snippet.save
			snippet.image.create(picture: picture) unless !picture
			redirect_to session.delete(:return_to)
			# Send Notification
			GroupMailer.group_snippet_notifications(snippet.group, snippet)
		else
			render 'form'
		end
	end

	def edit	
		is_current_user?
		session[:return_to] = request.referer
	end

	def update
		@snippet.update_attributes(snippet_params)
		redirect_to session.delete(:return_to)
	end

	def destroy
		@snippet.destroy
		redirect_to :back
	end

	def group_user_and_snippet_objects
		@snippet = Snippet.find(params[:id]) unless %w[index new create].include?(params[:action])
		@group = Group.find(params[:group_id])
		@user = User.find(params[:user_id])
	end

	def is_current_user?
		redirect_to group_user_snippets_path unless current_user.id == @user.id
	end

	def login_required
	  redirect_to new_user_session_path unless current_user
	end
	
	private 
		def snippet_params
			params.require(:snippet).permit(:content)
		end
end
