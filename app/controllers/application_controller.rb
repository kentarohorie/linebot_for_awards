class ApplicationController < ActionController::Base
  protect_from_forgery with: :nul_section
end
