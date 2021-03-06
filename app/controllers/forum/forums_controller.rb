class Forum::ForumsController < ApplicationController
  before_action :authenticate_user!

	add_breadcrumb "Home", :root_path
  add_breadcrumb "Categories", :forum_forum_categories_path

	def index
		if is_admin?
		  @forums = Forum::Forum.all.order(:position)
		else
      @forums = Forum::Forum.all.user_viewable
		end
	end

	def new
		if params[:category_id].nil?
			flash[:error] = "Category missing"
		  redirect_to :root
		else
		  @categories = Forum::ForumCategory.all
			category = Forum::ForumCategory.find(params[:category_id])

  	  add_breadcrumb category.name, category
  	  add_breadcrumb "Create", new_forum_forum_path(@forum)
			@forum = category.forums.new
		end
	end

	def show
		@forum = Forum::Forum.find(params[:id])
    @posts = @forum.forum_posts.ordered.paginate(:page => params[:page], :per_page => 5)

  	@allowed_to_post = false

  	if is_admin?
  		@allowed_to_post = @forum.active? || @forum.admin_only_posting?
  	elsif is_user?
  		@allowed_to_post = @forum.active?
  	end

  	add_breadcrumb @forum.forum_category.name, @forum.forum_category
  	add_breadcrumb @forum.name, @forum
	end

	def create
		@forum = Forum::Forum.create(allowed_params)

		if @forum.save
			flash[:success] = "Forum created."
			redirect_to @forum
		else
		  @categories = Forum::ForumCategory.all
			flash[:error] = "Error creating forum."
			render :new
		end
	end

	def update
		@forum = Forum::Forum.find(params[:id])
		old_category = @forum.forum_category
		@forum.update_attributes(allowed_params)

		if @forum.save
			flash[:success] = "Forum edited."
			redirect_to old_category
		else
			flash[:error] = "Error editing forum."
			render :edit
		end
	end

	def edit
		@categories = Forum::ForumCategory.all
		@forum = Forum::Forum.find(params[:id])
  	add_breadcrumb @forum.forum_category.name, @forum.forum_category
  	add_breadcrumb @forum.name, @forum
  	add_breadcrumb "Edit", edit_forum_forum_path(@forum)
	end

	private
	def allowed_params
	  params.require(:forum_forum).permit(:name, :description, :position, :status, :forum_category_id)
	end
end
