class InvitationsController < ApplicationController
  def new
    User.invite!(email: params[:user][:email])
    redirect_to :back
  end

  def create
    
  end

  def edit
    redirect_to root_path
  end

  def update
    
  end
end
