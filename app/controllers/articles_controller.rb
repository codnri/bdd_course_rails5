class ArticlesController < ApplicationController
  def index
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_parmas)
    @article.save
    flash[:success] = "Article has been created"
    redirect_to articles_path
  end
  
  private 
    def article_parmas
      params.require(:article).permit(:title,:body)
    end
  
end