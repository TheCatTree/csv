class EmberController < ApplicationController
  def bootstrap
    db_id
    render layout: false
  end
  
  private 
    def db_id
      if (params.has_key?(:id))
        cookies.permanent[:db_id] = params.require(:id)
      end
    end
  
end
