class EntriesController < ApplicationController
  before_filter :login_required, :except=>[:index,:show]
  before_filter :load_user
  layout 'pages'
  # GET /entries
  # GET /entries.xml
  def index
    
    #@page = params[:page].to_i
    #raise ArgumentError, "'page' setting cannot be less than 1 (#{@page} given)" and 
    params[:page]=params[:page].to_i <=0 ? 1 : params[:page]
    @entries = @user.entries.order.paginate(:page =>params[:page], :per_page =>3)    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end
  
  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find_by_id_and_user_id(params[:id],params[:user_id],:include=>[:user,[:comments=>:user]])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end
  
  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end
  
  # GET /entries/1/edit
  def edit
    @entry = @logged_in_user.entries.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to :action=>'index'
    
  end
  
  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])
    respond_to do |format|
      if logged_in_user.entries << @entry 
        @entry.save
        flash[:notice] = 'Entry was successfully created.'
        format.html { redirect_to user_entries_path}
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = @logged_in_user.entries.find(params[:id])
    
    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to user_entries_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = @logged_in_user.entries.find(params[:id])
    @entry.destroy
    
    respond_to do |format|
      format.html { redirect_to(user_entries_url) }
      format.xml  { head :ok }
    end
  end
  def load_user
    @user=User.find(params[:user_id])
  end
end
