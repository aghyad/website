class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :dump_params
  
  
  
  def dump_params
    Rails.logger.debug "\n\n\n\n\n\n\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    Rails.logger.debug "params ==> #{params.inspect}\n\n"
  end
  
  
  
  
end
