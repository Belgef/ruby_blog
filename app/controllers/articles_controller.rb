class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.page(params[:page]).order('created_at DESC')
    @custom_paginate_renderer = custom_paginate_renderer
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def create
    @article = Article.new(article_params)
    @article.category_id = params[:category_id] 

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def update
    @article = Article.find(params[:id])
    @article.category_id = params[:category_id]

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  def tagged
    if params[:tag].present? 
      @articles = Article.tagged_with(params[:tag])
    else 
      @articles = Article.postall
    end  
    @articles = @articles.paginate(:page => params[:page], :per_page => 2).order(id: :desc)
    @custom_paginate_renderer = custom_paginate_renderer
  end

  def search  
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else  
      @parameter = params[:search].downcase  
      @articles = Article.where('lower(title) LIKE :search OR lower(body) LIKE :search', search: "%#{@parameter}%").order(:created_at)
      @articles = @articles.paginate(:page => params[:page], :per_page => 2).order(id: :desc)
      @custom_paginate_renderer = custom_paginate_renderer
    end  
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end

end
