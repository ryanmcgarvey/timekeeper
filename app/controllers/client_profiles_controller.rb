class ClientProfilesController < ApplicationController

  def new
    @client = Client.find(params[:client_id])
    @client_profile = @client.client_profiles.build
  end

  def edit
    @client_profile = ClientProfile.find(params[:id])
  end

  def update
    @client_profile = ClientProfile.find(params[:id])
    @client_profile.update_attributes(params[:client_profile])
    redirect_to clients_path
  end

  def create
    ClientProfile.create!(params[:client_profile].merge(user_id: current_user.id))
    redirect_to clients_path
  end

end
