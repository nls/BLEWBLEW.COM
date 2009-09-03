class BackgroundsController < ApplicationController
  # GET /backgrounds
  # GET /backgrounds.xml
  def index
    @backgrounds = Background.paginate(:page => params[:page], :order=>"id DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @backgrounds }
    end
  end

  # GET /backgrounds/1
  # GET /backgrounds/1.xml
  def show
    @background = Background.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @background }
    end
  end

  # GET /backgrounds/new
  # GET /backgrounds/new.xml
  def new
    @background = Background.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @background }
    end
  end

  # GET /backgrounds/1/edit
  def edit
    @background = Background.find(params[:id])
    authorize(@background.author.id)
  end

  # POST /backgrounds
  # POST /backgrounds.xml
  def create
    @background = Background.new(params[:background])
    @background.author_id = session[:author].id
    respond_to do |format|
      if @background.save
        flash[:notice] = 'Se creó el background satisfactoriamente.'
        format.html { redirect_to(@background) }
        format.xml  { render :xml => @background, :status => :created, :location => @background }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @background.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /backgrounds/1
  # PUT /backgrounds/1.xml
  def update
    @background = Background.find(params[:id])
    authorize(@background.author.id)
    respond_to do |format|
      if @background.update_attributes(params[:background])
        flash[:notice] = 'Se editó el background satisfactoriamente.'
        format.html { redirect_to(@background) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @background.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /backgrounds/1
  # DELETE /backgrounds/1.xml
  def destroy
    @background = Background.find(params[:id])
    authorize(@background.author.id)
    @background.destroy

    respond_to do |format|
      format.html { redirect_to(backgrounds_url) }
      format.xml  { head :ok }
    end
  end
end
