class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  # GET /articles
  # GET /articles.json
  def index
    #@articles = Article.all
    @articles = current_user.blog.articles.page(params[:page]).per(5)
    @categories = Category.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    #@article = Article.new
    @article = current_user.blog.articles.new
    @article_categories = @article.categories.new
    @categories = Category.all
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    #@article = Article.new(article_params)
    @article = current_user.blog.articles.new(title: article_params[:title], content: article_params[:content], status: article_params[:status])
    picture = @article.pictures.new(name: picture_params[:picture])
    respond_to do |format|
      if @article.save && picture.save!
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params) && @article.pictures[0].update(name: picture_params[:picture])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    if @article.published?
      @article.make_draft
    else 
      @article.publish
    end
    if @article.save 
      redirect_to @article
    else
      render :show 
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

   # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :status, :user_id)
    end

    def picture_params
      params.require(:article).permit(:picture)
    end
end
