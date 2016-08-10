class Api::V1::EventsController < ApplicationController
    
  def index
    @db = Event.all()
    render json: @db
  end
  
  def show
    @db = Event.find(params[:id])
    render json: @db
  end
  

end
