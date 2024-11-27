class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about, :location]

  def home
  end

  def about
  end
end
