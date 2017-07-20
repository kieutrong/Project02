class UsersController < ApplicationController
  before_action :user_signed_in?
  before_action :load_user, except: :index
  load_and_authorize_resource

  def index
    @users = User.select(:id, :name, :email, :created_at)
      .page(params[:page]).per Settings.user.maximum_of_paginate
  end

  def show
    @follow = current_user.active_relationships.build
    @unfollow = current_user.active_relationships.find_by followed_id: @user.id
    @posts = @user.posts.page(params[:page]).per Settings.user.maximum_of_paginate
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_deleted"
    else
      flash[:danger] = t ".you_can_not_delete"
    end
    redirect_to users_path
  end

  def following
    @users = @user.following.page(params[:page]).per Settings.user.maximum_of_paginate
    render :show_follow
  end

  def followers
    @users = @user.followers.page(params[:page]).per Settings.user.maximum_of_paginate
    render :show_follow
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t(".not_find_user") << params[:id]
    redirect_to new_user_registration_path
  end
end
