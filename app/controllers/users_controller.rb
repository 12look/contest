class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_works = @user.works.order('created_at DESC').page(params[:page])
  end
end
