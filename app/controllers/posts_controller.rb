class PostsController < ApplicationController
  uses_yui_editor
  # GET /posts
  # GET /posts.xml
  def index
    if params[:year]
      @year = params[:year]
    else
      @year = Time.now.strftime('%Y')
    end
    
    if params[:month]
      if(params[:month].to_i < 10)
        params[:month] = "0"+params[:month].to_i.to_s
      end
      @month = params[:month]
    else
      @month = Time.now.strftime('%m')
    end
    @month_date = Date.new(@year.to_i, @month.to_i, 1)
    @posts = Post.paginate :page => params[:page],
             :conditions => { :created_at => @year+'-'+@month+'-01'..@year+'-'+@month+'-31',
                              :visible => true },
             :order=>'id DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    require "digest"
    @post = Post.find(params[:id])
    if(@post.visible != true && (!session[:author] || session[:author].id != @post.author_id))
      flash[:error] = "El post solicitado es invisible"
      redirect_to "/posts"
    end
    @comments = @post.comments.paginate(:page => params[:page])
    @comment = Comment.new
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    authorize
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    authorize(@post.author.id)
  end

  # POST /posts
  # POST /posts.xml
  def create
    authorize
    params[:post][:author_id] = session[:author].id
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = 'El post fue creado satisfactoriamente.'
        format.html { redirect_to "/posts" }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    authorize(@post.author.id)
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.comments.each do |comment|
      comment.destroy
    end
    @post.destroy
    authorize(@post.author.id)
    respond_to do |format|
      format.html { redirect_to("/about/"+@post.author.id.to_s+"#posts") }
      format.xml  { head :ok }
    end
  end
  
  def unhide
    @post = Post.find(params[:id])
    authorize(@post.author.id)
    @post.visible = true
    @post.save
    flash[:notice] = "El post se hizo visible satisfactoriamente"
    redirect_to "/about/"+@post.author.id.to_s
  end
end
