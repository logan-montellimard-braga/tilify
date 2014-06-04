class AdminpanelController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @users = User.all
    @admins = Admin.all
  end
end
