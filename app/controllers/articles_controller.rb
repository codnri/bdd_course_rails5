class ArticlesController < ApplicationController
  
  before_action :authenticate_user!, except: [:index,:show]
  before_action :set_article, only: [:show,:edit,:update,:destroy]
  
  def index
    @articles = Article.all
  end
  
  def show
    # @article = Article.find(params[:id])
    @comment = @article.comments.build
    @comments = @article.comments
  end
    

  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_parmas)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger]="Article has not been created"
      render :new
    end
  end
  
  def edit
    unless @article.user == current_user
      flash[:alert]= "You can only edit your own article."
      redirect_to root_path
    end
    # @article = Article.find(params[:id])
  end
  
  def update
  
    # @article = Article.find(params[:id])
    unless @article.user == current_user
      flash[:danger]= "You can only edit your own article."
      redirect_to root_path
    else
      if @article.update(article_parmas)
        flash[:success] = "Article has been updated"
        redirect_to @article
      else
        flash.now[:danger] = "Article has not been updated"
        render :edit
      end
    end
  end
  
  def destroy  
    # @article = Article.find(params[:id])
    if @article.destroy
      flash[:success]= "Article has been deleted"
      redirect_to articles_path
    end
  end
  
  protected
  
    def resource_not_found
      message =  "The article you are looking for could not be found"
      flash[:alert]=message
      redirect_to root_path
    end
  
  private 
    def article_parmas
      params.require(:article).permit(:title,:body)
    end
    
    def set_article
      @article = Article.find(params[:id])
    end
  
end