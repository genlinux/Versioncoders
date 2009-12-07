class NewslettersController < ApplicationController
  layout 'pages'
  before_filter :check_administrator_role
  # GET /newsletters
  # GET /newsletters.xml
  def index
    @newsletters = Newsletter.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @newsletters }
    end
  end
  
  # GET /newsletters/1
  # GET /newsletters/1.xml
  def show
    @newsletter = Newsletter.find(params[:id])
    
    #    respond_to do |format|
    #      format.html # show.html.erb
    #      format.xml  { render :xml => @newsletter }
    #    end
  end
  
  # GET /newsletters/new
  # GET /newsletters/new.xml
  def new
    @newsletter = Newsletter.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @newsletter }
    end
  end
  
  # GET /newsletters/1/edit
  def edit
     @newsletter = Newsletter.find_by_id_and_sent(params[:id],false)
     @newsletter.blank? ? redirect_to(newsletters_url) : @newsletter 
  end
  
  # POST /newsletters
  # POST /newsletters.xml
  def create
    @newsletter = Newsletter.new(params[:newsletter])
    
    respond_to do |format|
      if @newsletter.save
        flash[:notice] = 'Newsletter was successfully created.'
        format.html { redirect_to(@newsletter) }
        format.xml  { render :xml => @newsletter, :status => :created, :location => @newsletter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /newsletters/1
  # PUT /newsletters/1.xml
  def update
    @newsletter = Newsletter.find_by_id_and_sent(params[:id],false)
    
    respond_to do |format|
      if @newsletter.update_attributes(params[:newsletter])
        flash[:notice] = 'Newsletter was successfully updated.'
        format.html { redirect_to(@newsletter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /newsletters/1
  # DELETE /newsletters/1.xml
  def destroy
    @newsletter = Newsletter.find_by_id_and_sent(params[:id],false)
    @newsletter.destroy
    
    respond_to do |format|
      format.html { redirect_to(newsletters_url) }
      format.xml  { head :ok }
    end
  end
  # PUT /newsletters/1;send
  def sendmails
    newsletter = Newsletter.find_by_id_and_sent(params[:id],false)
    User.all.collect{|user| Notifier.deliver_newsletter(user, newsletter)}
    newsletter.update_attribute('sent', true)
    respond_to do |format|
      format.html { redirect_to(newsletters_url) }
      format.xml  { head :ok }
    end
  end
  
  
end
