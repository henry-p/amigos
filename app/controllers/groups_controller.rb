class GroupsController < ApplicationController


	def index

	end

	def show
		# if current_user
			@group = Group.find_by_id(params[:id])
			@posts = @group.posts(order: "created_at DESC")
			@snippets = @group.snippets(order: "created_at DESC")

			@commentables = (@posts.to_a + @snippets.to_a).sort_by(&:created_at).reverse[0,5]
		# else 
		# 	redirect_to root_path
		# end
	end

	def new
	end

	def edit
	end


end
