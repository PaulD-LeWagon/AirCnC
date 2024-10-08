class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    # What shall we do here, then!?
  end
end
