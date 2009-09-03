class AboutController < ApplicationController
  def index
    @authors = Author.find(:all, :order=>'id ASC')
  end
  
  def show
    @author = Author.find(params[:id])
    @visible_posts = Post.paginate(
                      :page => params[:page],
                      :conditions => { :visible => true, :author_id => @author.id })
    if session[:author]
      @invisible_posts = Post.paginate(
                          :page => params[:in_page],
                          :conditions => { :visible => false, :author_id => @author.id })
    end
  end
end
