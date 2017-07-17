class UsersController < ApplicationController
  before_action :load_user, only: [:show, :destroy]

  def index
    @users = User.select(:id, :name, :email, :created_at)
      .paginate page: params[:page], per_page: Settings.user.maximum_of_paginate
  end

  def show
    @posts = @user.posts.paginate page: params[:page],
      per_page: Settings.user.maximum_of_paginate
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_deleted"
    else
      flash[:danger] = t ".you_can_not_delete"
    end
    redirect_to users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t(".not_find_user") << params[:id]
    redirect_to new_user_registration_path
  end
end
