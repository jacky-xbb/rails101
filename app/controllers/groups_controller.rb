class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete, :join, :quit]
  before_action :set_group, only: [:show, :edit, :update, :delete, :join, :quit]
  before_action :check_permission, only: [:edit, :update, :delete]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @posts = @group.posts.recent.paginate(page: params[:page], per_page: 5)
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def delete
    if @group.destroy
      redirect_to groups_path, alert: "Group deleted"
    else
      redirect_to groups_path
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def join
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "Join Group Success"
    else
      flash[:warning] = "You are already a member!"
    end

    redirect_to group_path(@group)
  end

  def quit
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "You are not a member!"
    else
      flash[:warning] = "You are not a member!"
    end

    redirect_to group_path(@group)
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def check_permission
    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

end
