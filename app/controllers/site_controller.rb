class SiteController < ApplicationController
  def index
    if admin_signed_in?
      redirect_to adminpanel_index_path, notice: "Redirection vers le panel administrateur..."
    end
  end
end
