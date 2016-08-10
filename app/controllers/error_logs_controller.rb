class ErrorLogsController < ApplicationController
  def show
    @log = ErrorLog.find(params[:id])
  end
  
  private 
  
  def file_params
    params.require(:user_file).permit(:file)
  end
end
