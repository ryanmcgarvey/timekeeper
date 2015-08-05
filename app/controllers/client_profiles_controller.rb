class ClientProfilesController < ApplicationController

  def new
    @client = Client.find(params[:client_id])
    @client_profile = @client.client_profiles.build
  end

  def create
    ClientProfile.create!(params[:client_profile].merge(user_id: current_user.id))
    redirect_to clients_path
  end

end
