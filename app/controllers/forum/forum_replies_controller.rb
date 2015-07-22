class Forum::ForumRepliesController < ApplicationController
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Categories", :forum_forum_categories_path

  def new
    @post = Forum::ForumPost.find(params[:post_id])
    add_breadcrumb @post.forum.forum_category.name, forum_forum_category_path(@post.forum.forum_category)
    add_breadcrumb @post.forum.name, forum_forum_path(@post.forum)
    add_breadcrumb @post.subject.truncate(12), forum_forum_post_path(@post)
    add_breadcrumb "Reply", forum_forum_path(@post.forum)
    @reply = Forum::ForumReply.new
  end

  def create
    @post = Forum::ForumPost.find(params[:forum_forum_reply][:post_id])
    @reply = @post.forum_replies.create(allowed_params)
    @reply.user = current_user

    if @reply.save
      flash[:success] = "Reply successful"
      redirect_to forum_forum_post_path(@post)
    else
      add_breadcrumb @reply.forum_post.forum.forum_category.name, forum_forum_category_path(@reply.forum_post.forum.forum_category)
      add_breadcrumb @reply.forum_post.forum.name, forum_forum_path(@reply.forum_post.forum)
      add_breadcrumb @post.subject.truncate(12), forum_forum_post_path(@reply.forum_post)
      add_breadcrumb "Reply", forum_forum_path(@reply.forum_post.forum)
      flash[:error] = "Reply failed"
      render :new
    end
  end

  def edit
    @reply = Forum::ForumReply.find(params[:id])
      add_breadcrumb @reply.forum_post.forum.forum_category.name, forum_forum_category_path(@reply.forum_post.forum.forum_category)
      add_breadcrumb @reply.forum_post.forum.name, forum_forum_path(@reply.forum_post.forum)
      add_breadcrumb @reply.forum_post.subject.truncate(12), forum_forum_post_path(@reply.forum_post)
      add_breadcrumb "Edit", forum_forum_path(@reply.forum_post.forum)
  end

  def update
    @reply = Forum::ForumReply.find(params[:id])
    @reply.update_attributes(allowed_params)

    if @reply.save
      flash[:success] = "Update successful"
      redirect_to forum_forum_post_path(@post)
    else
      add_breadcrumb @reply.forum_post.forum.forum_category.name, forum_forum_category_path(@reply.forum_post.forum.forum_category)
      add_breadcrumb @reply.forum_post.forum.name, forum_forum_path(@reply.forum_post.forum)
      add_breadcrumb "Original Post", forum_forum_post_path(@reply.forum_post)
      add_breadcrumb "Reply", forum_forum_path(@reply.forum_post.forum)
      flash[:error] = "Update failed"
      render :edit
    end
  end

  private
  def allowed_params
    params.require(:forum_forum_reply).permit(:post_body, :email_users)
  end
end
