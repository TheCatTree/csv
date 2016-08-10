class Api::V1::VariablesController < ApplicationController
  
  def index
    @db = Variable.all()
    render json: @db
  end
  
  def show
    @db = Variable.find(params[:id])
    render json: @db
  end
  
  def update
     @variable = Variable.find(params[:id])
    @variable.name = params_name[:name]
    
    if @variable.save! 
    render json: @variable
      
      else
    render json: {
      status: 400,
      message: "Failed to rename Variable",
    }.to_json
    end
  end
  
  private
  
  def params_name
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:name])
  end
end
