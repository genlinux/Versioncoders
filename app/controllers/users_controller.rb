class UsersController < ApplicationController
  before_filter :check_administrator_role,:only=>[:index,:destroy,:enable]
  before_filter :login_required,:only=>[:edit,:update]
  layout 'pages'
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @entries = @user.entries.order.limit(3)
    @photos = @user.photos.order.limit(3)
    @flickr_feed=@user.flickr_feed if @user.flickr_id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  def show_by_username
    @user = User.find_by_username(params[:username])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end
  
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      
      if @user.save
        self.logged_in_user=@user
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(logged_in_user)
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled,false)
      flash[:notice]="User disabled"
    else
      flash[:error]="There was a problem disabling this user"
    end
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def enable
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled,true)
      flash[:notice]="User enabled"
    else
      flash[:error]="There was a problem enabling this user"
    end
    respond_to do |format|
      format.html { redirect_to(users_url)}
      format.xml { head :ok}
    end
  end
end
