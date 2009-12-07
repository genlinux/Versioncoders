class CommentsController < ApplicationController
  before_filter :login_required
  before_filter :load_entry
  layout 'pages'
  # GET /comments
  # GET /comments.xml
  #  def index
  #    @comments = Comment.find(:all)
  #
  #    respond_to do |format|
  #      format.html # index.html.erb
  #      format.xml  { render :xml => @comments }
  #    end
  #  end
  
  # GET /comments/1
  # GET /comments/1.xml
  #  def show
  #    @comment = Comment.find(params[:id])
  #
  #    respond_to do |format|
  #      format.html # show.html.erb
  #      format.xml  { render :xml => @comment }
  #    end
  #  end
  
  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end
  
  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end
  
  # POST /comments
  # POST /comments.xml
  def create
    #    @comment = Comment.new(:user_id=>@logged_in_user.id,:body=>params[:comment][:body])
    #
    #    respond_to do |format|
    #      if @entry.comments << @comment
    #        @comment.save
    #        flash[:notice] = 'Comment was successfully created.'
    #        Notifier.deliver_new_comment_notification(@comment)
    #        format.html { redirect_to user_entries_path }
    #        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
    #      else
    #        format.html { render :controller=>'entries',:action => "show",:user_id=>@entry.user,:entry_id=>@entry }
    #        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
    #      end
    #end
    @comment=@entry.comments.build(:user_id=>@logged_in_user.id,:body=>params[:comment][:body])
    respond_to do |format|
    @comment.save
    flash[:notice] = 'Comment was successfully created.'
    Notifier.deliver_new_comment_notification(@comment)
    format.html {redirect_to user_entry_path(@user,@entry)}
    format.js
    end
end

# PUT /comments/1
# PUT /comments/1.xml
#  def update
#    @comment = Comment.find(params[:id])
#
#    respond_to do |format|
#      if @comment.update_attributes(params[:comment])
#        flash[:notice] = 'Comment was successfully updated.'
#        format.html { redirect_to(@comment) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
# DELETE /comments/1
# DELETE /comments/1.xml
def destroy
  @comment = @entry.comments.find(params[:id])
  @comment.destroy
  
  respond_to do |format|
    format.html { redirect_to user_entry_path(@user,@entry) }
    format.xml  { head :ok }
  end
end
def load_entry
  @user = User.find(params[:user_id])
  @entry = Entry.find_by_user_id_and_id(params[:user_id],params[:entry_id],:include => :user)
end
end
