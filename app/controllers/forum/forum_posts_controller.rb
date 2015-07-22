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
    @post = @forum.forum_posts.new
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

  private
  def allowed_params
    params.require(:forum_forum_post).permit(:subject, :post_body, :position, :status, :forum_category_id)
  end
end