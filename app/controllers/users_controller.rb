require 'pry'

class UsersController < ApplicationController
  def index
    
  end

  def new
    
  end

  def edit
    
  end

  def show
    
  end

  def update
    user = User.find(params[:id])
    puts "HIIIIIIIIIIIIIII"
    puts params[:user][:avatar_img]
    user.avatar_img = params[:user][:avatar_img]
    puts user.avatar_img.url
    if user.save!
      redirect_to edit_user_registration_path
    else
      puts "There is error"
    end
  end
end
