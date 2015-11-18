class TimelogsController < ApplicationController

  def create
    binding.pry
    timelog = Timelog.create!(params[:timelog])
    redirect_to client_path(timelog.client)
  end

end
