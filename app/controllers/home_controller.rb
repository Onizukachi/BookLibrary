class HomeController < ApplicationController
  def index
    @main_categories = Category.last(4)
  end
end
