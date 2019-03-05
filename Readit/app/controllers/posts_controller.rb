class PostsController < ApplicationController


  def show
    @post = Post.find(params[:id])
    @top_comments = @post.comments.where(parent_id: nil)
  end

  def new
    @subs = Sub.all
    @post = Post.new 
  end

  def create
    @subs = Sub.all
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save 
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit 
    @post = Post.find(params[:id])
    @subs = Sub.all
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post 
      if @post.update(post_params)
        redirect_to post_url(@post)
      else
        flash.now[:errors] = @post.errors.full_messages
        render :edit 
      end
    else
      flash[:errors] = ["Can't edit a post that is not yours"]
      redirect_to subs_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end