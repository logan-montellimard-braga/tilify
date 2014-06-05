class AdminpanelController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @users = User.all
    @admins = Admin.all
    @public_messages = Message.where(:public => true)
    @private_messages = Message.where(:public => false)
  end

  def users
    @users = User.all
  end
end
