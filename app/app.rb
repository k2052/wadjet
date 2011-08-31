require 'sinatra/flash'  
require 'resque' 
require 'redis-store'
class Wadjet < Padrino::Application
  ##
  # Initializers
  #     
  
  # Core
  register Padrino::Helpers   
  register Padrino::Rendering   
  
  # Authorizaition
  register Padrino::Admin::AccessControl 
  register OmniAuthInitializer    
  Padrino.use Rack::Session::Redis      
    
  # Resources. JS, CSS handling ext
  register CompassInitializer
  register AssetHatInitializer      
  register Sinatra::Flash
  
  ##
  # App Settings 
  #    
  
  # Sessions
  set :login_page, "/login"  
  set :session_id, 'widget'    
  set :asset_uri_root, "/"

  ## 
  # Access Rules
  #                   
  
  access_control.roles_for :any do |role|
    role.protect "/"
    role.allow "/login"
    role.allow "/sessions"
  end 
  
  access_control.roles_for :registered, :admin do |role|
    role.allow "/"
  end  
  
  ## 
  # Error Handling
  #
  error 404 do 
    render 'errors/404'
  end
end