class RelationshipsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  load_and_authorize_resource

  def create
    @user = User.find_by id: params[:followed_id]

    if current_user.follow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t ".can_not_follow_user"
      redirect_to root_path
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed

    if current_user.unfollow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t ".can_not_follow_user"
      redirect_to root_path
    end
  end
end
