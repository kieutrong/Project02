class PostsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :user_signed_in?, only: [:create, :destroy]
  load_and_authorize_resource

  def index
    @posts = Post.search_post(params[:search]).order_by.
      page(params[:page]).per Settings.user.maximum_of_paginate
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      render json: {status: :success, html: render_to_string(@post)}
    else
      @feed_items = []
      render json: {status: :error, errors: @post.errors.messages}
    end
  end

  def destroy
    if @post.destroy
      render json: {status: :success}
    else
      render json: {status: :error, message: t(".delete_fails")}
    end
  end

  private

  def post_params
    params.require(:post).permit :content, :picture, :title, :list_tags
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url unless @post
  end
end
