class LandingController < ApplicationController
	
  def index
  	@global_published_articles = Article.where(status: 'published')
  end


end
