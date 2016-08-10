class Api::V1::ErrorLogsController < ApplicationController
  
  def index
    @db = ErrorLog.all()
    render json: @db
  end
  
  def show
    @db = ErrorLog.find(params[:id])
    render json: @db
  end
  
  def update
    @er = ErrorLog.find(params[:id])
    @er.name = error_logs_params[:name]
    
    if @er.save! 
    render json: @er
      else
    render json: {
      status: 400,
      message: "Failed to rename database",
    }.to_json
    end
  end
  
  private
  

  def error_logs_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:name])
  end
end
