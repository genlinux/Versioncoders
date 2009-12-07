class TopicsController < ApplicationController
  before_filter :load_forum
  before_filter :check_moderator_role,:only => [:destroy, :edit, :update]
  before_filter :login_required, :except => [:index, :show]
  
  layout 'pages'
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.forum_id(@forum).order.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end
  
  # GET /topics/1
  # GET /topics/1.xml
  def show
    #    @topic = Topic.find(params[:id])
    #    
    #    respond_to do |format|
    #      format.html # show.html.erb
    #      format.xml  { render :xml => @topic }
    #    end
    redirect_to forum_topic_posts_path(:forum_id => params[:forum_id], :topic_id => params[:id])
  end
  
  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = @forum.topics.build
    @post=Post.new
  end
  
  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end
  
  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new(:name =>params[:topic][:name],:forum_id =>params[:forum_id],:user_id => logged_in_user.id)
    @topic.save!
    @post = Post.new(:body => params[:post][:body],:topic_id => @topic.id,:user_id => logged_in_user.id)
    @post.save!
    respond_to do |format|
      format.html {redirect_to forum_topic_posts_path(:topic_id=>@topic,:forum_id=>@topic.forum.id)}
      format.xml{head :created,:location=>topic_path(:id=>@topic,:forum_id=>@topic.forum.id)}
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html { render :action => 'new' }
      format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
    end
  end
  
  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])
    
    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
        format.html { redirect_to(@topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.posts.each { |post| post.destroy }
    @topic.destroy
    
    respond_to do |format|
      format.html { redirect_to(forum_topics_url,:forum_id => params[:forum_id]) }
      format.xml  { head :ok }
    end
  end
  def load_forum
    @forum = Forum.find(params[:forum_id])
  end
end
