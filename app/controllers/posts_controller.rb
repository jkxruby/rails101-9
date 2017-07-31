class PostsController < ApplicationController
before_action :authenticate_user!, :only => [:new, :create, :delete, :update]

def new
  @group = Group.find(params[:group_id])
  @post = Post.new
end

def index
  @group = Group.find(params[:group_id])
  @posts.group = @group
end

def edit
  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])
  @post.group = @group
end

def create
  @group = Group.find(params[:group_id])
  @post = Post.new(post_params)
  @post.group = @group
  @post.user = current_user
  if @post.save
    redirect_to group_path(@group)
  else
    render :new
  end
end

def update
  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])

  if @post.update(post_params)
    redirect_to account_posts_path(@group), notice: "update success~"
  else
    render :edit
  end
end

def destroy
  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])
  @post.group = @group
  @post.destroy
  redirect_to account_path(@group), alert: "delete!"
end

private
def post_params
  params.require(:post).permit(:content)
end

end
