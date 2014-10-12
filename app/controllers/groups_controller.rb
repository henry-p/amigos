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
		@group = Group.new
	end

	def create
		@group = Group.new(group_params)
		if @group.save
			@membership = Membership.create(member_id: current_user.id, group_id: @group.id)
			flash[:notice] = "Group successfully created."
			redirect_to user_index_path
		else
			flash[:error] = "Group name already exists"
			redirect_to new_group_path
		end
	end

	def edit

	end

	private

	def group_params
    params.require(:group).permit(:name, :jefe_id)
	end
end
