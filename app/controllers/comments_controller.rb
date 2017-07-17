class CommentsController < ApplicationController
  before_action :load_comment, except: [:index, :new, :create]
  before_action :load_post, only: :create
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build comment_params

    if @comment.save
      render json: {status: :success, html: render_to_string(@comment)}
    else
      render json: {status: :error, errors: @comment.errors.messages}
    end
  end

  def edit
    render json: {
      status: :success,
      html: render_to_string(partial: "comments/edit_form",
        locals: {comment: @comment}, layout: false)
    }
  end

  def update
    if @comment.update_attributes comment_params
      render json: {
        status: :success,
        html: render_to_string(partial: "comments/comment",
          locals: {comment: @comment}, layout: false)
      }
    else
      render json: {
        status: :error,
      }
    end
  end

  def destroy
    if @comment.destroy
      render json: {status: :success}
    else
      render json: {status: :error, message: t(".delete_fail")}
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :user_id
  end

  def load_post
    @post = Post.find_by id: params[:post_id]

    return if @post
    flash[:danger] = t ".not_find_post"
    redirect_to root_path
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]

    return if @comment
    flash[:danger] = t ".not_find_comment"
    redirect_to root_path
  end
end
