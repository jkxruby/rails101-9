class GroupsController < ApplicationController
before_action :authenticate_user! ,only: [:new, :create, :update, :destroy, :destroy, :join, :quit]

def index
  @groups = Group.all
end

def show
  @group = Group.find(params[:id])
  @posts = @group.posts.recent.paginate(:page => params[:page], :per_page =>5)
end

def new
  @group = Group.new
end

def edit
  @group = Group.find(params[:id])
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

def update
  @group = Group.find(params[:id])
  if @group.update(group_params)
    redirect_to groups_path,notice: "update success"
  else
    render :edit
  end
end

def destroy
  @group = Group.find(params[:id])
  @group.destroy
  redirect_to groups_path,notice: "delete success"
end

def join
  @group = Group.find(params[:id])
  if !current_user.is_member_of?(@group)
    current_user.join!(@group)
    flash[:notice] = "加入本版成功"
  else
    flash[:warning] = "你已经加入本版了"
  end
  redirect_to group_path(@group)
end

def quit
  @group = Group.find(params[:id])
  if current_user.is_member_of?(@group)
    current_user.quit!(@group)
    flash[:alert] = "已经退出"
  else
    flash[:warning] = "你不是本版讨论版，怎么退出"
  end
  redirect_to group_path(@group)
end

private
def group_params
  params.require(:group).permit(:title, :description)
end

end
