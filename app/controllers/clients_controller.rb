class ClientsController < ApplicationController
  
  def index
    @clients = Client.all
  end
  
  def show
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(client_params)
    
    if @client.save
      redirect_to(clients_path, notice: 'Client Added')
    else
      render action: 'new'
    end
  end
  
  def edit
    @client = Client.find(params[:id])
  end
  
  def update
    @client = Client.find(params[:id])
    
    if @client.update(client_params)
      redirect_to(clients_path, notice: 'Client Updated')
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to(clients_path, notice: 'Client Deleted')
  end
  
  private
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def client_params
    params.require(:client).permit(:name, :hourly_rate, :supervision_rate, :training_rate)
  end
  
end