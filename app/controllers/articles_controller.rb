class ArticlesController < ApplicationController
  # impressionist 
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :authenticate_writer!, only: [:create, :update]
  before_filter :allow_iframe_requests, only: [:show]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.article_order(params[:page])
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    # impressionist(@article)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
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

  private

    def allow_iframe_requests
      response.headers.delete('X-Frame-Options')
    end

    def authenticate_writer!
      unless current_user.is_writer? || current_user.is_admin?
        redirect_to root_path, alert: "You are not authorized!"
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :image)
    end

    def require_same_user
      if current_user != @article.user
        flash[:alert] = "you can only edit or delete ypur own article"
        redirect_to articles_path
      end
    end
end
