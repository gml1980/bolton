class Forum::ForumCategoriesController < ApplicationController
	add_breadcrumb "Home", :root_path
  add_breadcrumb "Categories", :forum_forum_categories_path

	def index
		if is_admin?
		  @categories = Forum::ForumCategory.all.order(:position)
		else
			@categories = Forum::ForumCategory.all.user_viewable.order(:position)
		end
	end

	def new
		@category = Forum::ForumCategory.new
  	add_breadcrumb "Create", :new_forum_forum_category_path
	end

	def edit
		@category = Forum::ForumCategory.find(params[:id])
  	add_breadcrumb @category.name, @category
  	add_breadcrumb "Edit", edit_forum_forum_category_path(@category)
	end

	def show
		@category = Forum::ForumCategory.find(params[:id])

		if is_admin?
			@forums = @category.forums
		else
			@forums = @category.forums.user_viewable
		end

    add_breadcrumb @category.name, @category
	end

	def update
		@category = Forum::ForumCategory.find(params[:id])
		@category.update_attributes(allowed_params)

		if @category.save
			flash[:success] = "Category updated."
			redirect_to forum_forum_categories_path
		else
			flash[:error] = "Error editing category."
			render :edit
		end
	end

	def create
		@category = Forum::ForumCategory.create(allowed_params)

		if @category.save
			flash[:success] = "Category created."
			redirect_to forum_forum_categories_path
		else
			flash[:error] = "Error creating category."
			render :new
		end
	end

	private
	def allowed_params
		params.require(:forum_forum_category).permit(:name, :description, :position, :status)
	end
end
