class PhotosController < ApplicationController
  def index
    if request.path.include?("feeds") || request.path.include?("discover")
      render 'public'
    else
      puts "HERE"
      render 'personal'
    end
  end

  def new
    
  end
end
