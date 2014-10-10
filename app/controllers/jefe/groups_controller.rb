class Jefe::GroupsController < ApplicationController


	def edit
		@group = Group.find_by_id(params[:id])
		redirect_to root_path unless current_user.id == @group.jefe_id
	end

	def update
		group = Group.find_by_id(params[:id])
		group.update(group_params)
		flash[:notice] = "Your group was updated successfully."
		redirect_to "/groups/#{group.id}/edit"
	end

	def destroy
		@group = Group.find_by_id(params[:id])
		@group.destroy
		redirect_to user_index_path
	end

	private

	def group_params
    params.require(:group).permit(:name, :jefe_id)
	end
end