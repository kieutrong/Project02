class TagsController < ApplicationController
  before_action :load_tag, only: :show

  def show
    @post = @tag.posts.order_by.select(:id, :content, :title, :user_id, :created_at)
      .page(params[:page]).per Settings.user.maximum_of_paginate
  end

  private

  def load_tag
    @tag = Tag.find_by id: params[:id]

    return if @tag
    flash[:danger] = t ".not_find_tag"
    redirect_to root_path
  end
end
