# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_background
    @background = Background.find(:all, :limit=>1, :order=>"id DESC")
    @background[0]
  end
end
