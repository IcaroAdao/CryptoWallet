class ApplicationController < ActionController::Base
  before_action :set_locale
  
  private
  
  def set_locale
    if params[:locale]
      cookies[:locale] = params[:locale]
    end
    
    if cookies[:locale]
      puts "Teste"
      if I18n.locale != cookies[:locale]
        I18n.locale = cookies[:locale]
      end
    end
  end
end
