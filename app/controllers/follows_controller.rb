require 'pry'
class FollowsController < ApplicationController
  def create
    follow = current_user.following.build(followee_id: params[:followee_id])
    if follow.save
      flash[:notice] = 'Following user'
    else
      flash[:error] = 'Unable to follow user'
    end
    redirect_to request.referrer
  end

  def destroy
    follow = current_user.following.find_by(followee_id: params[:followee_id].to_i, follower_id: current_user.id)
    follow.destroy
    flash[:notice] = 'Unfollow user'
    redirect_to request.referrer
  end

end
