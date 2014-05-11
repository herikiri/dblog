class BlogController < ApplicationController
	before_action :authenticate_user!

	def index
		@user = current_user
		build_user_blog_on_first_time_login		
		@published_articles = @user.blog.articles.where(status: 'published')
    @categories = Category.all
	end

  def show
    @user = User.where(:name => request.subdomain).first || not_found
  end

  def not_found
    raise ActionController::RoutingError.new('User Not Found')
  end

  private 
  	def build_user_blog_on_first_time_login

  		if @user.sign_in_count == 1  
        if @user.blog.nil?
  				blog = @user.build_blog(attributes = {
    				name: @user.name.capitalize + "'s Blog"
    			} )
          if blog.save
            blog_img = blog.build_picture(name: File.open(Rails.application.config.assets.paths[0]+"/blue1x1.png"))
            blog_img.save!
          end
        end

        if @user.picture.nil?
          user_img = @user.build_picture(name: File.open(Rails.application.config.assets.paths[0]+"/grey1x1.png"))
          user_img.save!
        end

			end

  	end
end

