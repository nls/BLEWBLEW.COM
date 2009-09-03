class AuthorsController < ApplicationController
  # GET /authors
  # GET /authors.xml
  def index
    authorize
    @authors = Author.all
  end

  # GET /authors/1
  # GET /authors/1.xml
  def show
    authorize
    @author = Author.find(params[:id])
  end

  # GET /authors/new
  # GET /authors/new.xml
  def new
    authorize
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
    @author = Author.find(params[:id])
    authorize(@author.id)
  end

  # POST /authors
  # POST /authors.xml
  def create
    authorize
    @author = Author.new(params[:author])

    respond_to do |format|
      if @author.save
        flash[:notice] = 'Author was successfully created.'
        format.html { redirect_to(@author) }
        format.xml  { render :xml => @author, :status => :created, :location => @author }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @author.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /authors/1
  # PUT /authors/1.xml
  def update
    @author = Author.find(params[:id])
    authorize(@author.id)
    respond_to do |format|
      if @author.update_attributes(params[:author])
        session[:author] = @author
        flash[:notice] = 'Se editó el perfil satisfactoriamente.'
        format.html { redirect_to(@author) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @author.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.xml
  def destroy
    @author = Author.find(params[:id])
    authorize(@author.id)
    @author.destroy

    respond_to do |format|
      format.html { redirect_to(authors_url) }
      format.xml  { head :ok }
    end
  end
end
