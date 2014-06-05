class AdminpanelController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @users = User.all
    @admins = Admin.all
    @public_messages = Message.where(:public => true)
    @public_messages = @public_messages.reverse
    @private_messages = Message.where(:public => false)
    @private_messages = @private_messages.reverse
  end

  def users
    @users = User.all
  end

  def admins
    @admins = Admin.all
  end

  def messages
    @public_messages = Message.where(:public => true)
    @private_messages = Message.where(:public => false)
  end

  def tiles
  end
end
