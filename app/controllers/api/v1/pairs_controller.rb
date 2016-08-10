class Api::V1::PairsController < ApplicationController
  
  def index
    @db = Pair.all()
    render json: @db
  end
  
  def show
    @db = Pair.find(params[:id])
    render json: @db
  end
  

end
