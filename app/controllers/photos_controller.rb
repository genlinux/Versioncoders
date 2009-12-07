class PhotosController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :load_user
  layout 'pages'
  # GET /photos
  # GET /photos.xml
  def index
    @photos = @user.photos.order.paginate(:page=>params[:page],:per_page=>2)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end
  
  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find_by_user_id_and_id(params[:user_id],params[:id],:include => :user)
    if @photo.show_geo && (@photo.geo_lat && @photo.geo_long)
      @map = GMap.new("map_div_id")
      @map.control_init(:map_type => false, :small_zoom => true)
      @map.center_zoom_init([@photo.geo_lat, @photo.geo_long], 8)
      marker = GMarker.new([@photo.geo_lat, @photo.geo_long],
                       :title => @photo.title,
                       :info_window => @photo.body)
      @map.overlay_init(marker)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end
  
  # GET /photos/new
  # GET /photos/new.xml
  def new
    @user=User.find(@logged_in_user)
    @photo = Photo.new
    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true)
    @map.center_zoom_init([25,0], 1)
    @map.record_init @map.on_click(
     "function (overlay, point) { updateLocation(point); }")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end
  
  # GET /photos/1/edit
  def edit
    @photo = @logged_in_user.photos.find(params[:id])
    @map = GMap.new("map_div_id")
    @map.control_init(:large_map => true)
    if @photo.geo_lat && @photo.geo_long
      @map.center_zoom_init([@photo.geo_lat, @photo.geo_long], 8)
      marker = GMarker.new([@photo.geo_lat, @photo.geo_long],
       :title => @photo.title, :info_window => @photo.body)
      @map.overlay_init(marker)
    else
      @map.center_zoom_init([25,0], 1)
    end
    @map.record_init @map.on_click(
    "function (overlay, point) { updateLocation(point); }")
    rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
    
  end
  
  # POST /photos
  # POST /photos.xml
  def create
    
    @photo = Photo.new(params[:photo])
    respond_to do |format|
      
      if @logged_in_user.photos << @photo
        @photo.save  
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to user_photos_path}
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = @logged_in_user.photos.find(params[:id])
    
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to user_photos_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = @logged_in_user.photos.find(params[:id])
    @photo.destroy
    
    respond_to do |format|
      format.html { redirect_to (user_photos_url) }
      format.xml  { head :ok }
    end
  end
  def add_tag
    @photo = @logged_in_user.photos.find(params[:id])
    @photo.tag_list << params[:tag][:name]
    respond_to do |format|
      @photo.save
      @new_tag = @photo.reload.tags.last
      format.html {redirect_to edit_user_photo_path}
      format.js
    end
  end
  
  def remove_tag
    @photo = @logged_in_user.photos.find(params[:id])
    @tag_to_delete = @photo.tags.find(params[:tag_id])
    if @tag_to_delete
      respond_to do |format|
        @photo.tags.delete(@tag_to_delete)
        format.js
      end
    else
      render :nothing => true
    end
  end
  
  def load_user
    @user=User.find(params[:user_id])
  end
end
