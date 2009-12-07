class ArticlesController < ApplicationController
  before_filter :check_editor_role,:except=>[:index,:show]
  layout 'pages'
  # GET /articles
  # GET /articles.xml
  #  def index
  #    @articles = Article.find(:all)
  #
  #    respond_to do |format|
  #      format.html # index.html.erb
  #      format.xml  { render :xml => @articles }
  #    end
  #  end
  #
  #  # GET /articles/1
  #  # GET /articles/1.xml
  #  def show
  #    @article = Article.find(params[:id])
  #
  #    respond_to do |format|
  #      format.html # show.html.erb
  #      format.xml  { render :xml => @article }
  #    end
  #  end
  #
  #  # GET /articles/new
  #  # GET /articles/new.xml
  #  def new
  #    @article = Article.new
  #
  #    respond_to do |format|
  #      format.html # new.html.erb
  #      format.xml  { render :xml => @article }
  #    end
  #  end
  #
  #  # GET /articles/1/edit
  #  def edit
  #    @article = Article.find(params[:id])
  #  end
  #
  #  # POST /articles
  #  # POST /articles.xml
  #  def create
  #    @article = Article.new(params[:article])
  #
  #    respond_to do |format|
  #      if @article.save
  #        flash[:notice] = 'Article was successfully created.'
  #        format.html { redirect_to(@article) }
  #        format.xml  { render :xml => @article, :status => :created, :location => @article }
  #      else
  #        format.html { render :action => "new" }
  #        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
  #      end
  #    end
  #  end
  #
  #  # PUT /articles/1
  #  # PUT /articles/1.xml
  #  def update
  #    @article = Article.find(params[:id])
  #
  #    respond_to do |format|
  #      if @article.update_attributes(params[:article])
  #        flash[:notice] = 'Article was successfully updated.'
  #        format.html { redirect_to(@article) }
  #        format.xml  { head :ok }
  #      else
  #        format.html { render :action => "edit" }
  #        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
  #      end
  #    end
  #  end
  #
  #  # DELETE /articles/1
  #  # DELETE /articles/1.xml
  #  def destroy
  #    @article = Article.find(params[:id])
  #    @article.destroy
  #
  #    respond_to do |format|
  #      format.html { redirect_to(articles_url) }
  #      format.xml  { head :ok }
  #    end
  #  end
  
  #Code from Practical Rails Social Websites
  def index
    
    if params[:category_id]
      @articles = Article.order.published.include_user.category("#{params[:category_id].to_i}").paginate(:page => params[:page])
      
    else
      @articles = Article.find_all_by_published(true)
      @articles=Article.order.published.include_user.paginate(:page => params[:page],:per_page=>params[:per_page])
      
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
      format.rss  { render :rss => @articles,:layout=>false}
      format.atom { render :atom => @articles,:layout=>false}
    end
  end
  def new
    @article = Article.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end
  def create
    @article = Article.create(params[:article])
    @logged_in_user.articles << @article
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml { render :xml => @article.to_xml }
    end
  end
  def show
    if is_logged_in? && @logged_in_user.has_role?('Editor')
      @article=Article.find(params[:id])
    else
      @article=Article.find_by_id_and_published(params[:id],true)
    end
    respond_to do |format|
      format.html
      format.xml {render :xml=>@article}
    end
  end
  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end
  #  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])
    
    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
      else
        format.html { redirect_to admin_articles_url }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end
  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    
    respond_to do |format|
      format.html { redirect_to(admin_articles_url) }
      format.xml  { head :ok }
    end
  end
  def admin
    @articles = Article.order.paginate(:page=>params[:page])
  end
  
end
