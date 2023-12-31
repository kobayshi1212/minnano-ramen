class ApplicationController < ActionController::Base
  #Deviseコントローラーでリクエストが処理される前に configure_permitted_parameters メソッドを呼び出す
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller? 
  
  def after_sign_in_path_for(resource)
    mypage_path
  end
  
  protected
  
  #sign_upの際に、ユーザー名(name)のデータ操作を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) 
  end
end
