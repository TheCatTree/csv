class Api::V1::DatabController < Api::V1::BaseController
  def show
    @db = ErrorLog.find(params[:id])

    render json: @db
  end
  
  def variable
    @variable = Variable.find(params[:id])
    
    render json: @variable
  end
  def errorlogname
    @er = ErrorLog.find(params[:id])
    @er.name = parmas_name
    
    if @er.save! 
    render json: {
      status: 200,
      message: "Successfully renamed database",
    }.to_json
      
      else
    render json: {
      status: 400,
      message: "Failed to rename database",
    }.to_json
    end
  end
  def variablename
    @variable = Variable.find(params[:id])
    @variable.name = parmas_name
    
    if @variable.save! 
    render json: {
      status: 200,
      message: "Successfully renamed Variable",
    }.to_json
      
      else
    render json: {
      status: 400,
      message: "Failed to rename Variable",
    }.to_json
    end
  end
  def eventname
    @event = Event.find(params[:id])
    if @event.save! 
    render json: {
      status: 200,
      message: "Successfully renamed event",
    }.to_json
      
      else
    render json: {
      status: 400,
      message: "Failed to rename event",
    }.to_json
    end
  end
  def event
    @event = Event.find(params[:id])
    
    render json: @event
  end
     
  private
  
  def params_name
  params.require(:name)
  end
  
  def params_token
  params.require(:dbtoken)
  end
     
end
