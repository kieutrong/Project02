class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?
    @post = current_user.posts.build
    @feed_items = current_user.feed.page(params[:page]).per Settings.user.maximum_of_paginate
  end

  def introduce
  end

  def help
  end
end
