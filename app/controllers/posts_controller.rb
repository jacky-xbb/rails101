class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_group, only: [:new, :create, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.group = @group

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @post = @group.posts.find(params[:id])
  end

  def update
    @post = @group.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @post = @group.posts.find(params[:id])

    @post.destroy
    redirect_to account_posts_path, alert: "Post deleted"
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

end
