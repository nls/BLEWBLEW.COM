class HomeController < ApplicationController
  def index
    @headlines = Post.find(:all, :conditions => { :is_headline => true, :visible => true},
                            :limit => 3, :order => "id DESC")
    @recent_posts = Post.find(:all, :conditions => { :is_headline => false, :visible => true}, :limit => 6, :order => "id DESC")
  end
end
