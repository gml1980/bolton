class Forum::ForumPostsController < ApplicationController
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Categories", :forum_forum_categories_path

  def index
  end

  def new
    @forum = Forum::Forum.find(params[:forum_id])
    add_breadcrumb @forum.forum_category.name, forum_forum_category_path(@forum.forum_category)
    add_breadcrumb @forum.name, forum_forum_path(@forum)
    add_breadcrumb "Add Post", forum_forum_path(@forum)
    @post = Forum::ForumPost.new
  end

  def show
    @post = Forum::ForumPost.find(params[:id])
    add_breadcrumb @post.forum.forum_category.name, forum_forum_category_path(@post.forum.forum_category)
    add_breadcrumb @post.forum.name, forum_forum_path(@post.forum)
    add_breadcrumb @post.subject.truncate(12), forum_forum_post_path(@post)
  end

  def edit
    @post = Forum::ForumPost.find(params[:id])
    add_breadcrumb @post.forum.forum_category.name, forum_forum_category_path(@post.forum.forum_category)
    add_breadcrumb @post.forum.name, forum_forum_path(@post.forum)
    add_breadcrumb @post.subject.truncate(12), forum_forum_post_path(@post)
    add_breadcrumb "Edit", forum_forum_path(@post.forum)
  end

  def create
    @forum = Forum::Forum.find(params[:forum_forum_post][:forum_id])
    @post = @forum.forum_posts.new(allowed_params)
    @post.user = current_user

    if @post.save
      unless params[:forum_forum_post][:file_attachment].nil?
        params[:forum_forum_post][:file_attachment].each do |posted_file|
          @post.file_attachments.create(:post_file => posted_file)
        end
      end

      @post.touch
      flash[:success] = "Post successful"
      redirect_to forum_forum_post_path(@post)
    else
      flash[:error] = "Post failed"
      render :new
    end
  end

  def update
    @post = Forum::ForumPost.find(params[:id])
    @post.update_attributes(allowed_params)

    unless params[:forum_forum_post][:deleted_files].nil?
      @post.file_attachments.where(:id => params[:forum_forum_post][:deleted_files]).destroy_all
    end

    unless params[:forum_forum_post][:file_attachment].nil?
      params[:forum_forum_post][:file_attachment].each do |posted_file|
        @post.file_attachments.create(:post_file => posted_file)
      end
    end

    if @post.save
      flash[:success] = "Update successful"
      redirect_to forum_forum_post_path(@post)
    else
      flash[:error] = "Update failed"
      render :edit
    end
  end

  private
  def allowed_params
    params.require(:forum_forum_post).permit(:subject, :post_body, :sticky, :locked, :email_users)
  end
end
