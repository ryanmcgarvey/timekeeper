class ClientsController < ApplicationController

  def new
    @client = Client.new
  end

  def show
    @client = Client.find(params[:id])
    @client_profiles = @client.client_profiles.for_user(current_user)
  end

  def edit
    @client = Cliend.find(params[:id])
  end

  def create
    Client.create!(params[:client])
    redirect_to clients_path
  end


end
