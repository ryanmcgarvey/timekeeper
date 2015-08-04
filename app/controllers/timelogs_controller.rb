class TimelogsController < ApplicationController

  def create
    timelog = Timelog.create!(params[:timelog])
    redirect_to client_path(timelog.client)
  end


end
