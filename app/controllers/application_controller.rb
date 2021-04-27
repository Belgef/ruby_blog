class ApplicationController < ActionController::Base
  layout "app-start", only: [:index]
end
