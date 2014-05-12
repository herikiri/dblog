class BlogController < ApplicationController
  before_action :set_blog, only: [:edit, :update]
	before_action :authenticate_user!

	def index
		@user = current_user
    if @user.blog.nil?
		  @blog = build_user_blog_on_first_time_login
    else
      @blog = @user.blog
    end
		@published_articles = @user.blog.articles.where(status: 'published').order("updated_at DESC").page(params[:page]).per(5)
    @categories = Category.all
	end

  def show
    @user = User.where(:name => request.subdomain).first || not_found
  end

  def edit
  end

  def update
   
    respond_to do |format|
      if @blog.update(name: blog_params[:name], description: blog_params[:description]) && 
          @blog.picture.update(name: picture_params[:banner]) && 
            @blog.user.picture.update(name: avatar_params[:avatar])

        format.html { redirect_to blog_index_url, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: blog_index_url }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def not_found
    raise ActionController::RoutingError.new('User Not Found')
  end

  private 
  	def build_user_blog_on_first_time_login
  		if @user.sign_in_count == 1  
				blog = @user.build_blog(attributes = {
  				name: @user.name.capitalize + "'s Blog"
  			} )
        if blog.save
          blog_img = blog.build_picture(name: File.open(Rails.application.config.assets.paths[0]+"/blue1x1.png"))
          blog_img.save!
        end
       

        if @user.picture.nil?
          user_img = @user.build_picture(name: File.open(Rails.application.config.assets.paths[0]+"/grey1x1.png"))
          user_img.save!
        end

			end

      blog
  	end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:name, :description)
    end

    def picture_params
      params.require(:blog).permit(:banner)
    end

    def avatar_params
      params.require(:blog).permit(:avatar)
    end

    def set_blog
      @blog = current_user.blog
      @user = current_user
    end
end

