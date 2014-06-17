class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def build_flash_errors(model)
    if model.errors.any?
      flash[:errors] = model.errors.messages
    end
  end

  def build_multiple_flash_errors(*models)
    flash[:errors] = {}
    models.flatten.each do |model|
      if model.errors.any?
        flash[:errors][model.class.to_s.downcase.to_sym] = model.errors.messages
      end
    end
  end
  
  
end
