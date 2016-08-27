class HomeController < ApplicationController
  def index
    @works = Work.all.order('created_at DESC').limit(4)
    render 'home/index'
  end

  def juries
    @juries = User.juries
    render 'home/juries'
  end
end