class WelcomeController < ApplicationController
  def index
    flash[:alert] = "This is an alert"
  end
end
