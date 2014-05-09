class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def index
		@user = current_user
		build_user_blog_on_first_time_login		
		@published_articles = @user.blog.articles.where(status: 'published')
	end

  def show
    @user = User.where(:name => request.subdomain).first || not_found
  end

  def not_found
    raise ActionController::RoutingError.new('User Not Found')
  end

  private 
  	def build_user_blog_on_first_time_login
  		if @user.sign_in_count == 1 && @user.blog.nil?
				@user.create_blog(attributes = {
  				name: @user.name.capitalize + "'s Blog"
  			} )
			end
  	end
end
