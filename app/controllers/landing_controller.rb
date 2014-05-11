class LandingController < ApplicationController
	before_action :set_article, only: [:show]

  def index
  	@global_published_articles = Article.where(status: 'published').page(params[:page]).per(5)
    @categories = Category.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

end
