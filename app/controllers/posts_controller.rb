class PostsController < ApplicationController
  before_action :correct_user, only: :destroy
  before_action :user_signed_in?, only: [:create, :destroy]

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".micropost_created"
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".post_deleted"
    else
      flash[:danger] = t ".error"
    end
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit :content, :picture, :title
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url unless @post
  end
end
